//
//  Enums.swift
//

import Foundation

/// Environments to play Magic: The Gathering in
public enum Game: String, Codable, CaseIterable {
    case paper, mtgo, arena
}

/// Comparison strategies for determining what makes a card "unique"
///
/// Full reference: https://scryfall.com/docs/api/cards/search#unique-rollup-modes
public enum UniqueMode: String, Codable, CaseIterable {
    case cards, art, prints
}

/// Fields that Scryfall can sort cards by
///
/// Full reference: https://scryfall.com/docs/api/cards/search#sorting-cards
public enum SortMode: String, Codable, CaseIterable {
    case name, set, released, rarity, color, usd, tix, eur, cmc, power, toughness, edhrec, artist
}

/// Directions that Scryfall can order cards in
///
/// Full reference: https://scryfall.com/docs/api/cards/search#sorting-cards
public enum SortDirection: String, Codable, CaseIterable {
    case auto, asc, desc
}

/// Formats for playing Magic: the Gathering
public enum Format: String, CaseIterable {
    case standard, historic, pioneer, modern, legacy, pauper, vintage, penny, commander, brawl
}

/// Currency types that Scryfall provides prices for
public enum Currency: String, CaseIterable {
    case usd, eur, tix, usdFoil
}
