//
//  Card.swift
//

import Foundation

/// A Magic: the Gathering card
///
/// [Scryfall documentation](https://scryfall.com/docs/api/cards)
public struct Card: Codable, Identifiable, Hashable, Sendable {
  // MARK: Core fields
  /// The identifier of this card on Scryfall
  public var id: UUID
  /// The identifier of this card on MTG Arena
  public var arenaId: Int?
  /// The identifier of this card on MTG Online
  public var mtgoId: Int?
  /// The identifier of the foil version of this card on MTG Online
  public var mtgoFoilId: Int?
  /// The identifiers of this card on Wizards of the Coast's [Gatherer](https://gatherer.wizards.com/Pages/Default.aspx)
  public var multiverseIds: [Int]?
  /// The identifier of this card on TCGPlayer
  public var tcgplayerId: Int?
  /// The identifier of the etched version of this card on TCGPlayer
  public var tcgplayerEtchedId: Int?
  /// The identifier of this card on Card Market
  public var cardMarketId: Int?
  /// The identifier for this card’s oracle identity.
  ///
  /// For more information on this property, see [Scryfall's documentation](https://scryfall.com/docs/api/cards#core-card-fields)
  /// - Note: Scryfall's documentation lists this as required but it's nil for reversible cards
  public var oracleId: String?
  /// The language that this specific printing was printed in
  public var lang: String
  /// A link to where you can begin paginating all re/prints for this card on Scryfall’s API.
  public var printsSearchUri: String
  /// A link to this card’s rulings list on Scryfall’s API.
  public var rulingsUri: String
  /// A link to this card’s permapage on Scryfall’s website.
  public var scryfallUri: String
  /// A link to this card object on Scryfall’s API.
  public var uri: String

  // MARK: Gameplay fields
  /// An array of related cards (tokens, meld parts, etc) or nil if there are none
  public var allParts: [RelatedCard]?
  /// An array of all the faces that a card has or nil if it's a single-faced card
  public var cardFaces: [Face]?
  /// The converted mana cost of a card, now called the "mana value"
  /// - Note: Scryfall's documentation lists this as required but it's nil for reversible cards
  public var cmc: Double?
  /// An array of colors representing this card's color identity.
  ///
  /// Color identity is used to determine what cards are legal in a Commander deck. See the [comprehensive rules](https://magic.wizards.com/en/rules) for more information
  public var colorIdentity: [Color]
  /// An array of the colors in this card’s color indicator or nil if it doesn't have one
  ///
  /// Color indicators are used to specify the color of a card that has no mana symbols
  public var colorIndicator: [Color]?
  /// An array of the colors in this card's mana cost
  public var colors: [Color]?
  /// This card’s overall rank/popularity on EDHREC. Not all cards are ranked.
  public var edhrecRank: Int?
  /// This card’s hand modifier, if it is Vanguard card. This value will contain a delta, such as -1.
  public var handModifier: String?
  /// An array of the keywords on this card (deathouch, first strike, etc)
  public var keywords: [String]
  /// This card's layout (normal, transform, split, etc)
  public var layout: Layout
  /// The formats that this card is legal in
  public var legalities: Legalities
  /// This card’s life modifier, if it is Vanguard card. This value will contain a delta, such as +2.
  public var lifeModifier: String?
  /// This card's starting loyalty counters if it's a planeswalker
  public var loyalty: String?
  /// The mana cost for this card.
  ///
  /// This value will be any empty string "" if the cost is absent. Remember that per the game rules, a missing mana cost and a mana cost of {0} are different values.
  public var manaCost: String?
  /// The name of this card
  ///
  /// If the card has multiple faces the names will be separated by a "//" such as "Wear // Tear"
  public var name: String
  /// The oracle text for this card
  public var oracleText: String?
  /// True if this card is an oversized card
  public var oversized: Bool
  /// The power of this card if it's a creature
  public var power: String?
  /// The colors of mana that this card _could_ produce
  public var producedMana: [Color]?
  /// True if this card is on the Reserved List
  public var reserved: Bool
  /// The toughness of this card if it's a creature
  public var toughness: String?
  /// This card's types, separated by a space
  /// - Note: Tokens don't have type lines
  public var typeLine: String?

  // MARK: Print fields
  /// The name of the artist who illustrated this card
  public var artist: String?
  /// True if this card was printed in booster packs
  public var booster: Bool
  /// The color of this card's border
  public var borderColor: BorderColor
  /// The Scryfall ID for the card back design present on this card.
  /// - Note: Scryfall's documentation lists this as required but it's nil for multi-faced cards
  public var cardBackId: UUID?
  /// This card's collector number
  public var collectorNumber: String
  /// True if you should consider avoiding use of this print downstream
  ///
  /// [Comment from Scryfall's blog](https://scryfall.com/blog/regarding-wotc-s-recent-statement-on-depictions-of-racism-220)
  public var contentWarning: Bool?
  /// Whether this card has been released digitally
  public var digital: Bool
  /// The different finishes that this card was printed in
  public var finishes: [Card.Finish]
  /// The just-for-fun name printed on the card (such as for Godzilla series cards).
  public var flavorName: String?
  /// This card's flavor text if any
  public var flavorText: String?
  /// The frame effects if any
  public var frameEffects: [FrameEffect]?
  /// The type of frame this card was printed with
  public var frame: Frame
  /// True if this card's art is larger than normal
  public var fullArt: Bool
  /// An array of the games this card has been released in
  public var games: [Game]
  /// True if Scryfall has a high-res image of this card
  public var highresImage: Bool
  /// An ID for this card's art that remains consistent across reprints
  public var illustrationId: UUID?
  /// A computer-readable indicator for the state of this card’s image
  public var imageStatus: ImageStatus
  /// An object listing available imagery for this card.
  public var imageUris: ImageUris?
  /// An object containing daily price information for this card
  public var prices: Prices
  /// The localized name printed on this card, if any.
  public var printedName: String?
  /// The localized text printed on this card, if any.
  public var printedText: String?
  /// The localized type line printed on this card, if any.
  public var printedTypeLine: String?
  /// True if this card is a promotional printing
  public var promo: Bool
  /// An array of strings describing what categories of promo cards this card falls into.
  public var promoTypes: [String]?
  /// A dictionary of URIs to this card’s listing on major marketplaces.
  public var purchaseUris: [String: String]?
  /// This card's rarity
  public var rarity: Rarity
  /// A dictionary of links to other MTG resources
  public var relatedUris: [String: String]
  /// This card's release date
  public var releasedAt: String
  /// True if this card has been printed before
  public var reprint: Bool
  /// Link to this card's set on Scryfall
  public var scryfallSetUri: String
  /// This card's full set name
  public var setName: String
  /// A link to this card's set on Scryfall
  public var setSearchUri: URL
  /// The type of set this card was printed in
  public var setType: MTGSet.`Type`
  /// A link to this card's set object on the Scryfall API
  public var setUri: String
  /// This card's set code
  public var set: String
  /// True if this was a story spotlight card
  public var storySpotlight: Bool
  /// True if this card doesn't have any text on it
  public var textless: Bool
  /// True if this card is a variation of another printing
  public var variation: Bool
  /// The id of the card this card is a variation of
  public var variationOf: UUID?
  /// This card's watermark, if any
  public var watermark: String?
  /// An object with information on when this card was previewed and by whom
  public var preview: Preview?

  // swiftlint:disable function_body_length
  public init(
    arenaId: Int? = nil,
    mtgoId: Int? = nil,
    mtgoFoilId: Int? = nil,
    multiverseIds: [Int]? = nil,
    tcgplayerId: Int? = nil,
    tcgplayerEtchedId: Int? = nil,
    cardMarketId: Int? = nil,
    id: UUID,
    oracleId: String,
    lang: String,
    printsSearchUri: String,
    rulingsUri: String,
    scryfallUri: String,
    uri: String,
    allParts: [RelatedCard]? = nil,
    cardFaces: [Face]? = nil,
    cmc: Double,
    colorIdentity: [Color],
    colorIndicator: [Color]? = nil,
    colors: [Color]? = nil,
    edhrecRank: Int? = nil,
    handModifier: String? = nil,
    keywords: [String],
    layout: Layout,
    legalities: Legalities,
    lifeModifier: String? = nil,
    loyalty: String? = nil,
    manaCost: String? = nil,
    name: String,
    oracleText: String? = nil,
    oversized: Bool,
    power: String? = nil,
    producedMana: [Color]? = nil,
    reserved: Bool,
    toughness: String? = nil,
    typeLine: String? = nil,
    artist: String? = nil,
    booster: Bool,
    borderColor: BorderColor,
    cardBackId: UUID? = nil,
    collectorNumber: String,
    contentWarning: Bool? = nil,
    digital: Bool,
    finishes: [Finish],
    flavorName: String? = nil,
    flavorText: String? = nil,
    frameEffects: [FrameEffect]? = nil,
    frame: Frame,
    fullArt: Bool,
    games: [Game],
    highresImage: Bool,
    illustrationId: UUID? = nil,
    imageStatus: ImageStatus,
    imageUris: ImageUris? = nil,
    prices: Prices,
    printedName: String? = nil,
    printedText: String? = nil,
    printedTypeLine: String? = nil,
    promo: Bool,
    promoTypes: [String]? = nil,
    purchaseUris: [String: String]? = nil,
    rarity: Card.Rarity,
    relatedUris: [String: String],
    releasedAt: String,
    reprint: Bool,
    scryfallSetUri: String,
    setName: String,
    setSearchUri: URL,
    setType: MTGSet.`Type`,
    setUri: String,
    set: String,
    storySpotlight: Bool,
    textless: Bool,
    variation: Bool,
    variationOf: UUID? = nil,
    watermark: String? = nil,
    preview: Preview? = nil
  ) {
    self.arenaId = arenaId
    self.mtgoId = mtgoId
    self.mtgoFoilId = mtgoFoilId
    self.multiverseIds = multiverseIds
    self.tcgplayerId = tcgplayerId
    self.tcgplayerEtchedId = tcgplayerEtchedId
    self.cardMarketId = cardMarketId
    self.id = id
    self.oracleId = oracleId
    self.lang = lang
    self.printsSearchUri = printsSearchUri
    self.rulingsUri = rulingsUri
    self.scryfallUri = scryfallUri
    self.uri = uri
    self.allParts = allParts
    self.cardFaces = cardFaces
    self.cmc = cmc
    self.colorIdentity = colorIdentity
    self.colorIndicator = colorIndicator
    self.colors = colors
    self.edhrecRank = edhrecRank
    self.handModifier = handModifier
    self.keywords = keywords
    self.layout = layout
    self.legalities = legalities
    self.lifeModifier = lifeModifier
    self.loyalty = loyalty
    self.manaCost = manaCost
    self.name = name
    self.oracleText = oracleText
    self.oversized = oversized
    self.power = power
    self.producedMana = producedMana
    self.reserved = reserved
    self.toughness = toughness
    self.typeLine = typeLine
    self.artist = artist
    self.booster = booster
    self.borderColor = borderColor
    self.cardBackId = cardBackId
    self.collectorNumber = collectorNumber
    self.contentWarning = contentWarning
    self.digital = digital
    self.finishes = finishes
    self.flavorName = flavorName
    self.flavorText = flavorText
    self.frameEffects = frameEffects
    self.frame = frame
    self.fullArt = fullArt
    self.games = games
    self.highresImage = highresImage
    self.illustrationId = illustrationId
    self.imageStatus = imageStatus
    self.imageUris = imageUris
    self.prices = prices
    self.printedName = printedName
    self.printedText = printedText
    self.printedTypeLine = printedTypeLine
    self.promo = promo
    self.promoTypes = promoTypes
    self.purchaseUris = purchaseUris
    self.rarity = rarity
    self.relatedUris = relatedUris
    self.releasedAt = releasedAt
    self.reprint = reprint
    self.scryfallSetUri = scryfallSetUri
    self.setName = setName
    self.setSearchUri = setSearchUri
    self.setType = setType
    self.setUri = setUri
    self.set = set
    self.storySpotlight = storySpotlight
    self.textless = textless
    self.variation = variation
    self.variationOf = variationOf
    self.watermark = watermark
    self.preview = preview
  }
  // swiftlint:enable function_body_length
}
