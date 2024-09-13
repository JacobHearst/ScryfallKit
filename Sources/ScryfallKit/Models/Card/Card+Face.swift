//
//  Card+Face.swift
//

import Foundation

extension Card {
  /// A single face of a multi-faced card
  ///
  /// [Scryfall documentation](https://scryfall.com/docs/api/layouts#card-faces)
  public struct Face: Codable, Hashable, Sendable {
    /// The converted mana cost of this card face, now called the "mana value"
    public var cmc: Double?
    /// The identifier for this card face’s oracle identity.
    ///
    /// For more information on this property, see [Scryfall's documentation](https://scryfall.com/docs/api/cards#core-card-fields)
    public var oracleId: String?
    /// The name of the artist who illustrated this card
    public var artist: String?
    /// An array of the colors in this card’s color indicator or nil if it doesn't have one
    ///
    /// Color indicators are used to specify the color of a card that has no mana symbols
    public var colorIndicator: [Card.Color]?
    /// An array of the colors in this card's mana cost
    public var colors: [Card.Color]?
    /// This card's flavor text if any
    public var flavorText: String?
    /// An ID for this card face's art that remains consistent across reprints
    public var illustrationId: UUID?
    /// An object listing available imagery for this card.
    public var imageUris: ImageUris?
    /// This card's starting loyalty counters if it's a planeswalker
    public var loyalty: String?
    /// The mana cost for this card.
    ///
    /// This value will be any empty string "" if the cost is absent. Remember that per the game rules, a missing mana cost and a mana cost of {0} are different values.
    public var manaCost: String
    /// The name of this card
    ///
    /// If the card has multiple faces the names will be separated by a "//" such as "Wear // Tear"
    public var name: String
    /// The oracle text for this card
    public var oracleText: String?
    /// The power of this card if it's a creature
    public var power: String?
    /// The localized name printed on this card, if any.
    public var printedName: String?
    /// The localized text printed on this card, if any.
    public var printedText: String?
    /// The localized type line printed on this card, if any.
    public var printedTypeLine: String?
    /// The toughness of this card if it's a creature
    public var toughness: String?
    /// This card's types, separated by a space
    /// - Note: Tokens don't have type lines
    public var typeLine: String?
    /// This card's watermark, if any
    public var watermark: String?

    public init(
      artist: String? = nil,
      colorIndicator: [Card.Color]? = nil,
      colors: [Card.Color]? = nil,
      flavorText: String? = nil,
      illustrationId: UUID? = nil,
      imageUris: ImageUris? = nil,
      loyalty: String? = nil,
      manaCost: String,
      name: String,
      oracleText: String? = nil,
      power: String? = nil,
      printedName: String? = nil,
      printedText: String? = nil,
      printedTypeLine: String? = nil,
      toughness: String? = nil,
      typeLine: String? = nil,
      watermark: String? = nil
    ) {
      self.artist = artist
      self.colorIndicator = colorIndicator
      self.colors = colors
      self.flavorText = flavorText
      self.illustrationId = illustrationId
      self.imageUris = imageUris
      self.loyalty = loyalty
      self.manaCost = manaCost
      self.name = name
      self.oracleText = oracleText
      self.power = power
      self.printedName = printedName
      self.printedText = printedText
      self.printedTypeLine = printedTypeLine
      self.toughness = toughness
      self.typeLine = typeLine
      self.watermark = watermark
    }
  }
}
