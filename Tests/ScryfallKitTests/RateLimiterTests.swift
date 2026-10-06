//
//  RateLimiterTests.swift
//

import XCTest

@testable import ScryfallKit

class RateLimiterTests: XCTestCase {
    private func elapsed(_ block: () async -> Void) async -> TimeInterval {
        let start = Date()
        await block()
        return Date().timeIntervalSince(start)
    }

    func testFirstCallDoesNotWait() async {
        // Given
        let limiter = RateLimiter(requestsPerSecond: 2)

        // When
        let duration = await elapsed { await limiter.waitIfNeeded() }

        // Then
        XCTAssertLessThan(duration, 0.2)
    }

    func testSecondCallWaitsForMinInterval() async {
        // Given
        let limiter = RateLimiter(requestsPerSecond: 5)  // 0.2s interval
        await limiter.waitIfNeeded()

        // When
        let duration = await elapsed { await limiter.waitIfNeeded() }

        // Then
        XCTAssertGreaterThanOrEqual(duration, 0.18)
        XCTAssertLessThan(duration, 0.5)
    }

    func testCallAfterIntervalHasElapsedDoesNotWait() async throws {
        // Given
        let limiter = RateLimiter(requestsPerSecond: 20)  // 0.05s interval
        await limiter.waitIfNeeded()
        try await Task.sleep(nanoseconds: 100_000_000)

        // When
        let duration = await elapsed { await limiter.waitIfNeeded() }

        // Then
        XCTAssertLessThan(duration, 0.04)
    }

    func testSequentialCallsAreSpacedOut() async {
        // Given
        let limiter = RateLimiter(requestsPerSecond: 10)  // 0.1s interval

        // When
        let duration = await elapsed {
            for _ in 0..<4 { await limiter.waitIfNeeded() }
        }

        // Then: 3 enforced gaps of 0.1s after the free first call
        XCTAssertGreaterThanOrEqual(duration, 0.28)
    }

    func testConcurrentCallsAreSpacedOut() async {
        // Given
        let limiter = RateLimiter(requestsPerSecond: 10)  // 0.1s interval

        // When
        let duration = await elapsed {
            await withTaskGroup(of: Void.self) { group in
                for _ in 0..<4 { group.addTask { await limiter.waitIfNeeded() } }
            }
        }

        // Then: concurrent callers must still be serialized into 0.1s slots
        XCTAssertGreaterThanOrEqual(duration, 0.28)
    }
}
