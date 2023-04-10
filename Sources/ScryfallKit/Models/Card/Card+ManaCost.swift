//
//  Card+ManaCost.swift
//

import Foundation

extension Card {
    /// The mana cost of a card
    ///
    /// [Scryfall documentation](https://scryfall.com/docs/api/colors)
    public struct ManaCost: Codable {
        public var cost: String
        public var cmc: Double
        public var colors: [Card.Color]
        public var colorless: Bool
        public var monocolored: Bool
        public var multicolored: Bool

        public init(cost: String, cmc: Double, colors: [Card.Color], colorless: Bool, monocolored: Bool, multicolored: Bool) {
            self.cost = cost
            self.cmc = cmc
            self.colors = colors
            self.colorless = colorless
            self.monocolored = monocolored
            self.multicolored = multicolored
        }
    }
}
