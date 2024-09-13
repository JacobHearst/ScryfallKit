//
//  Card+ManaCost.swift
//

import Foundation

extension Card {
  /// The mana cost of a card
  ///
  /// Returned by ``ScryfallClient/parseManaCost(_:completion:)``
  ///
  /// [Scryfall documentation](https://scryfall.com/docs/api/colors)
  public struct ManaCost: Codable {
    /// The normalized cost, with correctly-ordered and wrapped mana symbols.
    public var cost: String
    /// The mana value. If you submit Un-set mana symbols, this decimal could include fractional parts.
    public var cmc: Double
    /// The colors of the given cost.
    public var colors: [Card.Color]
    /// True if the cost is colorless.
    public var colorless: Bool
    /// True if the cost is monocolored.
    public var monocolored: Bool
    /// True if the cost is multicolored.
    public var multicolored: Bool

    public init(
      cost: String, cmc: Double, colors: [Card.Color], colorless: Bool, monocolored: Bool,
      multicolored: Bool
    ) {
      self.cost = cost
      self.cmc = cmc
      self.colors = colors
      self.colorless = colorless
      self.monocolored = monocolored
      self.multicolored = multicolored
    }
  }
}
