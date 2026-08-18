//
//  RateLimiter.swift
//

import Foundation

/// Throttles outgoing requests to stay under a maximum rate.
///
/// Scryfall requires API usage to stay under 10 requests per second. Pass an instance of this type to
/// ``ScryfallClient/init(userAgent:logger:rateLimiter:)`` to have every request wait its turn automatically.
public actor RateLimiter {
  private let minInterval: TimeInterval
  private var lastRequestTime: Date?

  /// - Parameter requestsPerSecond: The maximum number of requests allowed per second. Defaults to `10`,
  ///   matching Scryfall's documented limit.
  public init(requestsPerSecond: Double = 10) {
    self.minInterval = 1.0 / requestsPerSecond
  }

  /// Suspends until it's safe to send another request, then records the time of that request.
  func waitIfNeeded() async {
    if let lastRequestTime {
      let remaining = minInterval - Date().timeIntervalSince(lastRequestTime)
      if remaining > 0 {
        try? await Task.sleep(nanoseconds: UInt64(remaining * 1_000_000_000))
      }
    }
    lastRequestTime = Date()
  }
}
