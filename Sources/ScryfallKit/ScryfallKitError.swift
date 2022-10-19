//
//  ScryfallKitError.swift
//  

import Foundation

/// An error thrown by the `ScryfallKit` module
enum ScryfallKitError: Error, CustomStringConvertible {
    /// Internal error, a request was tried with an invalid URL
    case invalidUrl
    case scryfallError(ScryfallError)
    case networkTimedOut(Int)
    case unexpectedNilResult
    case singleFacedCard
    case noDataReturned
    case failedToCast(String)

    var description: String {
        switch self {
        case .invalidUrl:
            return "Invalid URL"
        case .scryfallError(let error):
            return error.details
        case .networkTimedOut(let time):
            return "Network request timed out after \(time) seconds"
        case .unexpectedNilResult:
            return "Received unexpected nil result from network service"
        case .singleFacedCard:
            return "Tried to access card faces on card with a single face"
        case .noDataReturned:
            return "No data was returned by the server"
        case .failedToCast(let details):
            return "Failed to cast \(details)"
        }
    }
}
