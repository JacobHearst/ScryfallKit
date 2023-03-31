//
//  Card+enums.swift
//  

import Foundation

extension Card {
    /// A value or combination of values that uniquely identify a Magic card
    public enum Identifier {
        case scryfallID(id: String)
        case mtgoID(id: Int)
        case multiverseID(id: Int)
        case arenaID(id: Int)
        case tcgPlayerID(id: Int)
        case cardMarketID(id: Int)
        case setCodeCollectorNo(setCode: String, collectorNo: String, lang: String? = nil)

        /// The name of the service that the identifer is linked to
        var provider: String {
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
                return "scryfall"
            }
        }

        /// The id value of the identifier, if present. Only not present for set code + collector number
        var id: String? {
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

    /// A value or combination of values that uniquely identifies a Magic card for the purposes of retrieving a collection of cards.
    public enum CollectionIdentifier {
        case scryfallID(id: String)
        case mtgoID(id: Int)
        case multiverseID(id: Int)
        case oracleID(id: String)
        case illustrationID(id: String)
        case name(_: String)
        case nameAndSet(name: String, set: String)
        case collectorNoAndSet(collectorNo: String, set: String)

        var json: [String: String] {
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

    /// Finishes for a printed card
    public enum Finish: String, Codable, CaseIterable {
        case nonfoil, foil, etched, glossy
    }

    /// Status of Scryfall's image asset for this card
    ///
    /// Full reference: https://scryfall.com/docs/api/images#image-statuses
    public enum ImageStatus: String, Codable, CaseIterable {
        case missing, placeholder, lowres
        case highresScan = "highres_scan"
    }

    /// Types of images provided by Scryfall
    ///
    /// Full reference: https://scryfall.com/docs/api/images
    public enum ImageType: String, Codable, CaseIterable {
        case png, large, normal, small
        case artCrop = "art_crop"
        case borderCrop = "border_crop"
    }

    /// Card rarities
    public enum Rarity: String, Codable, CaseIterable, Comparable {
        case common, uncommon, rare, special, mythic, bonus

        /// Order according to Scryfall
        public static func < (lhs: Card.Rarity, rhs: Card.Rarity) -> Bool {
            let order: [Card.Rarity] = [.bonus, .special, .common, .uncommon, .rare, .mythic]
            return order.firstIndex(of: lhs)! < order.firstIndex(of: rhs)!
        }
    }

    /// Layouts for a Magic card
    ///
    /// Full reference: https://scryfall.com/docs/api/layouts
    public enum Layout: String, CaseIterable, Codable {
        case normal, split, flip, transform, meld, leveler, saga, adventure, planar, scheme, vanguard, token, emblem, augment, host, `class`, unknown
        case modalDfc = "modal_dfc"
        case doubleSided = "double_sided"
        case doubleFacedToken = "double_faced_token"
        case artSeries = "art_series"
        case reversibleCard = "reversible_card"

        public init(from decoder: Decoder) throws {
            self = try Layout(rawValue: decoder.singleValueContainer().decode(RawValue.self)) ?? .unknown
            if self == .unknown, let rawValue = try? String(from: decoder) {
                print("Decoded unknown FrameEffect: \(rawValue)")
            }
        }
    }

    /// Legality status strings
    public enum Legality: String, Codable, CaseIterable, Hashable {
        case legal, restricted, banned
        case notLegal = "not_legal"

        public var label: String {
            switch self {
            case .notLegal: return "Not Legal"
            default: return rawValue.capitalized
            }
        }
    }

    /// A string representing one of the colors (and colorless) in Magic
    public enum Color: String, Codable, CaseIterable, Comparable {
        // swiftlint:disable:next identifier_name
        case W, U, B, R, G, C

        public static func < (lhs: Color, rhs: Color) -> Bool {
            let order: [Color] = [.W, .U, .B, .R, .G, .C]
            return order.firstIndex(of: lhs)! < order.firstIndex(of: rhs)!
        }
    }

    /// Card border colors
    public enum BorderColor: String, Codable, CaseIterable {
        case black, borderless, gold, silver, white
    }

    /// Card frames
    ///
    /// Full reference: https://scryfall.com/docs/api/frames
    public enum Frame: String, Codable, CaseIterable {
        case v1993 = "1993"
        case v1997 = "1997"
        case v2003 = "2003"
        case v2015 = "2015"
        case future
    }

    /// Effects applied to a Magic card frame
    ///
    /// Full reference: https://scryfall.com/docs/api/frames#frame-effects
    public enum FrameEffect: String, Codable, CaseIterable {
        case legendary, miracle, nyxtouched, draft, devoid, tombstone, colorshifted, inverted, sunmoondfc, compasslanddfc, originpwdfc, mooneldrazidfc, waxingandwaningmoondfc, showcase, extendedart, companion, etched, snow, lesson, convertdfc, fandfc, unknown

        public init(from decoder: Decoder) throws {
            self = try FrameEffect(rawValue: decoder.singleValueContainer().decode(RawValue.self)) ?? .unknown
            if self == .unknown, let rawValue = try? String(from: decoder) {
                print("Decoded unknown FrameEffect: \(rawValue)")
            }
        }
    }
}
