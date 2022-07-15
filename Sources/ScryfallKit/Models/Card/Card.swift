//
//  File.swift
//  
//
//  Created by Jacob Hearst on 6/8/21.
//

import Foundation

public struct Card: Codable, Identifiable, Hashable {
    // MARK: Fields
    // Core fields
    public var arenaId: Int?
    public var mtgoId: Int?
    public var mtgoFoilId: Int?
    public var multiverseIds: [Int]?
    public var tcgplayerId: Int?
    public var tcgplayerEtchedId: Int?
    public var cardMarketId: Int?
    public var id: UUID
    public var oracleId: String
    public var lang: String
    public var printsSearchUri: String
    public var rulingsUri: String
    public var scryfallUri: String
    public var uri: String

    // Gameplay fields
    public var allParts: [RelatedCard]?
    public var cardFaces: [CardFace]?
    public var cmc: Double
    public var colorIdentity: [Color]
    public var colorIndicator: [Color]?
    public var colors: [Color]?
    public var edhrecRank: Int?
    public var handModifier: String?
    public var keywords: [String]
    public var layout: Layout
    public var legalities: CardLegality
    public var lifeModifier: String?
    public var loyalty: String?
    public var manaCost: String?
    public var name: String
    public var oracleText: String?
    public var oversized: Bool
    public var power: String?
    public var producedMana: [Color]?
    public var reserved: Bool
    public var toughness: String?
    public var typeLine: String? // Tokens don't have type lines

    // Print fields
    public var artist: String?
    public var booster: Bool
    public var borderColor: BorderColor
    public var cardBackId: UUID? // Scryfall's documentation lists this as required but it's nil for multi-faced cards
    public var collectorNumber: String
    public var contentWarning: Bool?
    public var digital: Bool
    public var finishes: [Card.Finish]
    public var flavorName: String?
    public var flavorText: String?
    public var frameEffects: [FrameEffect]?
    public var frame: Frame.RawValue
    public var fullArt: Bool
    public var games: [Game]
    public var highresImage: Bool
    public var illustrationId: UUID?
    public var imageStatus: ImageStatus
    public var imageUris: ImageUris?
    public var prices: CardPrices
    public var printedName: String?
    public var printedText: String?
    public var printedTypeLine: String?
    public var promo: Bool
    public var promoTypes: [String]?
    public var purchaseUris: [String : String]?
    public var rarity: Rarity
    public var relatedUris: [String : String]
    public var releasedAt: String
    public var reprint: Bool
    public var scryfallSetUri: String
    public var setName: String
    public var setSearchUri: URL
    public var setType: Set.`Type`
    public var setUri: String
    public var set: String
    public var storySpotlight: Bool
    public var textless: Bool
    public var variation: Bool
    public var variationOf: UUID?
    public var watermark: String?
    public var preview: Preview?
    
    public init(arenaId: Int? = nil,
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
                cardFaces: [CardFace]? = nil,
                cmc: Double,
                colorIdentity: [Color],
                colorIndicator: [Color]? = nil,
                colors: [Color]? = nil,
                edhrecRank: Int? = nil,
                handModifier: String? = nil,
                keywords: [String],
                layout: Layout,
                legalities: CardLegality,
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
                finishes: [Card.Finish],
                flavorName: String? = nil,
                flavorText: String? = nil,
                frameEffects: [FrameEffect]? = nil,
                frame: Frame.RawValue,
                fullArt: Bool,
                games: [Game],
                highresImage: Bool,
                illustrationId: UUID? = nil,
                imageStatus: Card.ImageStatus,
                imageUris: ImageUris? = nil,
                prices: CardPrices,
                printedName: String? = nil,
                printedText: String? = nil,
                printedTypeLine: String? = nil,
                promo: Bool,
                promoTypes: [String]? = nil,
                purchaseUris: [String : String]? = nil,
                rarity: Card.Rarity,
                relatedUris: [String : String],
                releasedAt: String,
                reprint: Bool,
                scryfallSetUri: String,
                setName: String,
                setSearchUri: URL,
                setType: Set.`Type`,
                setUri: String,
                set: String,
                storySpotlight: Bool,
                textless: Bool,
                variation: Bool,
                variationOf: UUID? = nil,
                watermark: String? = nil,
                preview: Preview? = nil) {
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
}
