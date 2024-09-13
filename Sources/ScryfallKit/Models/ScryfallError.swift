//
//  ScryfallError.swift
//

import Foundation

/// An error returned by the Scryfall REST API
public struct ScryfallError: Codable, CustomStringConvertible, Sendable {
  /// An integer HTTP status code for this error.
  public var status: Int
  /// A computer-friendly string representing the appropriate HTTP status code.
  public var code: String
  /// A human-readable string explaining the error.
  public var details: String
  /// A computer-friendly string that provides additional context for the main error.
  ///
  /// For example, an endpoint many generate HTTP 404 errors for different kinds of input. This field will provide a label for the specific kind of 404 failure, such as ambiguous.
  public var type: String?
  /// If your input also generated non-failure warnings, they will be provided as human-readable strings in this array.
  public var warnings: [String]?

  public init(
    status: Int, code: String, details: String, type: String? = nil, warnings: [String]? = nil
  ) {
    self.status = status
    self.code = code
    self.details = details
    self.type = type
    self.warnings = warnings
  }

  public var description: String {
    return """
      Scryfall Error
      - Status: \(status)
      - Code: \(code)
      - Details: \(details)
      - Type?: \(String(describing: type))
      - Warnings?: \(String(describing: warnings))
      """
  }
}
