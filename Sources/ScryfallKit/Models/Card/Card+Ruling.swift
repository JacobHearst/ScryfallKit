//
//  Card+Ruling.swift
//

import Foundation

extension Card {
  /// An object representing a ruling on a specific card
  public struct Ruling: Codable, Identifiable, Sendable {
    /// A value or combination of values that can identify a ruling. Used to find rulings for specific cards
    public enum Identifier {
      case scryfallID(id: String)
      case mtgoID(id: Int)
      case multiverseID(id: Int)
      case arenaID(id: Int)
      case collectorNumberSet(collectorNumber: String, set: String)
    }

    /// A computer-readable string indicating which company produced this ruling
    public enum Source: String, Codable, Sendable {
      case scryfall
      case wotc
    }

    /// A computer-readable string indicating which company produced this ruling
    public var source: Source
    /// The date when the ruling or note was published.
    public var publishedAt: String
    /// The text of the ruling.
    public var comment: String
    /// The card's oracle id
    public var oracleId: String

    /// An id made by concatenating the oracle id and the comment itself
    public var id: String { oracleId + comment }

    public init(source: Source, publishedAt: String, comment: String, oracleId: String) {
      self.source = source
      self.publishedAt = publishedAt
      self.comment = comment
      self.oracleId = oracleId
    }
  }
}
