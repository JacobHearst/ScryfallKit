//
//  Card+enums.swift
//  
//
//  Created by Jacob Hearst on 7/13/22.
//

import Foundation

extension Card {
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

    public enum Finish: String, Codable, CaseIterable {
        case nonfoil, foil, etched, glossy
    }

    public enum ImageStatus: String, Codable, CaseIterable {
        case missing, placeholder, lowres
        case highresScan = "highres_scan"
    }

    public enum ImageType: String, Codable, CaseIterable {
        case png, large, normal, small
        case artCrop = "art_crop"
        case borderCrop = "border_crop"
    }

    public enum Rarity: String, Codable, CaseIterable, Comparable {
        case common, uncommon, rare, special, mythic, bonus
        
        /// Order according to Scryfall
        public static func < (lhs: Card.Rarity, rhs: Card.Rarity) -> Bool {
            switch lhs {
            case .bonus: return true // "Smallest"
            case .special: return rhs != .bonus // Only "larger" than bonus
            case .common: return ![.bonus, .special].contains(rhs)
            case .uncommon: return ![.bonus, .special, .common].contains(rhs)
            case .rare: return rhs == .mythic // Only "smaller" than mythic
            case .mythic: return false // "Largest"
            }
        }
    }
}
