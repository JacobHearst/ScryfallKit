//
//  ScryfallKitError.swift
//

import Foundation

/// An error thrown by the `ScryfallKit` module
public enum ScryfallKitError: LocalizedError, CustomStringConvertible {
  /// Internal error, a request was tried with an invalid URL
  case invalidUrl
  /// An error returned by Scryfall's API such as for an invalid search
  case scryfallError(ScryfallError)
  case singleFacedCard
  case noDataReturned
  case failedToCast(String)

  public var errorDescription: String? {
    description
  }

  public var description: String {
    switch self {
    case .invalidUrl:
      return "Invalid URL"
    case .scryfallError(let error):
      return error.details
    case .singleFacedCard:
      return "Tried to access card faces on card with a single face"
    case .noDataReturned:
      return "No data was returned by the server"
    case .failedToCast(let details):
      return "Failed to cast \(details)"
    }
  }
}
