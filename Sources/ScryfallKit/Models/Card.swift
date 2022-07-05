//
//  File.swift
//  
//
//  Created by Jacob Hearst on 6/8/21.
//

import Foundation

public struct Card: Codable, Identifiable {
    // MARK: Enums
    public enum Identifier {
        case scryfallID(id: String)
        case mtgoID(id: Int)
        case multiverseID(id: Int)
        case arenaID(id: Int)
        case tcgPlayerID(id: Int)
        case cardMarketID(id: Int)
        case setCodeCollectorNo(setCode: String, collectorNo: String, lang: String? = nil)

        public var provider: String? {
            switch self {
            case .mtgoID:
                return "mtgo"
            case .multiverseID:
                return "multiverse"
            case .arenaID:
                return "arena"
            case .tcgPlayerID:
                return "tcgplayer"
            case .cardMarketID:
                return "cardmarket"
            default:
                return nil
            }
        }

        public var id: String? {
            switch self {
            case .scryfallID(let id):
                return id
            case .mtgoID(let id):
                return String(id)
            case .multiverseID(let id):
                return String(id)
            case .arenaID(let id):
                return String(id)
            case .tcgPlayerID(let id):
                return String(id)
            case .cardMarketID(let id):
                return String(id)
            default:
                return nil
            }
        }
    }

    public enum CollectionIdentifier {
        case scryfallID(id: String)
        case mtgoID(id: Int)
        case multiverseID(id: Int)
        case oracleID(id: String)
        case illustrationID(id: String)
        case name(_: String)
        case nameAndSet(name: String, set: String)
        case collectorNoAndSet(collectorNo: String, set: String)

        internal var json: [String: String] {
            switch self {
            case .scryfallID(let id):
                return ["id": id]
            case .mtgoID(let id):
                return ["mtgo_id": "\(id)"]
            case .multiverseID(let id):
                return ["multiverse_id": "\(id)"]
            case .oracleID(let id):
                return ["oracle_id": id]
            case .illustrationID(let id):
                return ["illustration_id": id]
            case .name(let name):
                return ["name": name]
            case .nameAndSet(let name, let set):
                return ["name": name, "set": set]
            case .collectorNoAndSet(let collectorNo, let set):
                return ["collector_number": collectorNo, "set": set]
            }
        }
    }

    public enum Finish: String, Codable {
        case nonfoil, foil, etched, glossy
    }

    public enum ImageStatus: String, Codable {
        case missing, placeholder, lowres
        case highresScan = "highres_scan"
    }

    public enum ImageType: String, Codable {
        case png, large, normal, small
        case artCrop = "art_crop"
        case borderCrop = "border_crop"
    }

    public enum Rarity: String, Codable {
        case common, uncommon, rare, special, mythic, bonus
    }

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
}

public struct CardPrices: Codable {
    public var tix: String?
    public var usd: String?
    public var usdFoil: String?
    public var eur: String?
}

public struct RelatedCard: Codable {
    public enum Component: String, Codable {
        case token
        case meldPart = "meld_part"
        case meldResult = "meld_result"
        case comboPiece = "combo_piece"
    }

    public var id: UUID
    public var component: Component
    public var name: String
    public var typeLine: String
    public var uri: String
}

public struct CardFace: Codable {
    public var artist: String?
    public var colorIndicator: [Color]?
    public var colors: [Color]?
    public var flavorText: String?
    public var illustrationId: UUID?
    public var imageUris: ImageUris?
    public var loyalty: String?
    public var manaCost: String
    public var name: String
    public var oracleText: String?
    public var power: String?
    public var printedName: String?
    public var printedText: String?
    public var printedTypeLine: String?
    public var toughness: String?
    public var typeLine: String? // Tokens don't have type lines
    public var watermark: String?
}

public struct Preview: Codable {
    public var source: String
    public var sourceUri: String
    public var previewedAt: String
}

public struct ImageUris: Codable {
    public let small: String?
    public let normal: String?
    public let large: String?
    public let png: String?
    public let artCrop: String?
    public let borderCrop: String?

    private enum CodingKeys: String, CodingKey {
        case small
        case normal
        case large
        case png
        case artCrop = "art_crop"
        case borderCrop = "border_crop"
    }

    public func uri(for type: Card.ImageType) -> String? {
        switch type {
        case .artCrop:
            return artCrop
        case .borderCrop:
            return borderCrop
        case .large:
            return large
        case .png:
            return png
        case .normal:
            return normal
        case .small:
            return small
        }
    }
}

public struct CardLegality: Codable {
    public let standard: Legality?
    public let historic: Legality?
    public let pioneer: Legality?
    public let modern: Legality?
    public let legacy: Legality?
    public let pauper: Legality?
    public let vintage: Legality?
    public let penny: Legality?
    public let commander: Legality?
    public let brawl: Legality?
}
