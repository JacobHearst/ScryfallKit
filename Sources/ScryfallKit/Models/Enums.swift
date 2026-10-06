//
//  Enums.swift
//

import Foundation

/// Environments to play Magic: The Gathering in
public struct Game: RawRepresentable, Codable, CaseIterable, Sendable, Equatable, Hashable {
  public static let paper = Game(rawValue: "paper")
  public static let mtgo = Game(rawValue: "mtgo")
  public static let arena = Game(rawValue: "arena")
  public static let astral = Game(rawValue: "astral")
  public static let sega = Game(rawValue: "sega")

  public static let allCases: [Game] = [
    .paper,
    .mtgo,
    .arena,
    .astral,
    .sega,
  ]

  public let rawValue: String

  public init(rawValue: String) {
    self.rawValue = rawValue
  }
}

/// Comparison strategies for determining what makes a card "unique"
///
/// [Scryfall documentation](https://scryfall.com/docs/api/cards/search#unique-rollup-modes)
public enum UniqueMode: String, Codable, CaseIterable, Sendable {
  case cards, art, prints
}

/// Fields that Scryfall can sort cards by
///
/// [Scryfall documentation](https://scryfall.com/docs/api/cards/search#sorting-cards)
public enum SortMode: String, Codable, CaseIterable, Sendable {
  case name, set, released, rarity, color, usd, tix, eur, cmc, power, toughness, edhrec, artist,
    spoiled
}

/// Directions that Scryfall can order cards in
///
/// [Scryfall documentation](https://scryfall.com/docs/api/cards/search#sorting-cards)
public enum SortDirection: String, Codable, CaseIterable, Sendable {
  case auto, asc, desc
}

/// Formats for playing Magic: the Gathering
public enum Format: String, Codable, CaseIterable, Sendable {
  case standard, future, historic, timeless, gladiator, pioneer, modern, legacy, pauper, vintage,
    penny, commander, oathbreaker, standardbrawl, brawl, alchemy, paupercommander, duel, oldschool,
    premodern, predh
}

/// Currency types that Scryfall provides prices for
public enum Currency: String, Codable, CaseIterable, Sendable {
  case usd, usdFoil, usdEtched, eur, eurFoil, eurEtched, tix
}
