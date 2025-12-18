//
//  Catalog.swift
//

import Foundation

/// A struct containing an array of Magic datapoints
///
/// [Scryfall documentation](https://scryfall.com/docs/api/catalogs)
public struct Catalog: Codable, Sendable {
  /// The catalog type. Each of these types represents a different `/catalogs` endpoint
  public enum `Type`: String, Codable, CaseIterable, Sendable {
    case cardNames = "card-names"
    case artistNames = "artist-names"
    case wordBank = "word-bank"
    case supertypes
    case cardTypes = "card-types"
    case artifactTypes = "artifact-types"
    case battleTypes = "battle-types"
    case creatureTypes = "creature-types"
    case enchantmentTypes = "enchantment-types"
    case landTypes = "land-types"
    case planeswalkerTypes = "planeswalker-types"
    case spellTypes = "spell-types"
    case powers, toughnesses, loyalties
    case keywordAbilities = "keyword-abilities"
    case keywordActions = "keyword-actions"
    case abilityWords = "ability-words"
    case flavorWords = "flavor-words"
    case watermarks
  }

  /// The number of items in the `data` array
  public var totalValues: Int

  /// An array of data points
  public var data: [String]

  public init(totalValues: Int, data: [String]) {
    self.totalValues = totalValues
    self.data = data
  }
}
