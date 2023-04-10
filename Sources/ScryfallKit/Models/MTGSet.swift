//
//  MTGSet.swift
//

import Foundation

/// A set represents a group of related Magic cards
///
/// [Scryfall documentation](https://scryfall.com/docs/api/sets)
public struct MTGSet: Codable, Identifiable, Hashable {
    public enum Identifier {
        case code(code: String)
        case scryfallID(id: String)
        case tcgPlayerID(id: String)

        var identifier: String {
            switch self {
            case .code(let code):
                return code
            case .scryfallID(let id):
                return id
            case .tcgPlayerID(let id):
                return id
            }
        }
    }

    public enum `Type`: String, Codable {
        // While "masters" is in fact not inclusive, it's also a name that we can't control
        // swiftlint:disable:next inclusive_language
        case core, expansion, masters, masterpiece, spellbook, commander, planechase, archenemy, vanguard, funny, starter, box, promo, token, memorabilia, arsenal, alchemy, minigame, unknown
        case fromTheVault = "from_the_vault"
        case premiumDeck = "premium_deck"
        case duelDeck = "duel_deck"
        case draftInnovation = "draft_innovation"
        case treasureChest = "treasure_chest"

        public init(from decoder: Decoder) throws {
            self = try Self(rawValue: decoder.singleValueContainer().decode(RawValue.self)) ?? .unknown
            if self == .unknown, let rawValue = try? String(from: decoder) {
                print("Decoded unknown MTGSet Type: \(rawValue)")
            }
        }
    }

    public var id: UUID
    public var code: String
    public var mtgoCode: String?
    public var tcgplayerId: Int?
    public var name: String
    public var setType: MTGSet.`Type`
    public var releasedAt: String?
    public var blockCode: String?
    public var block: String?
    public var parentSetCode: String?
    public var cardCount: Int
    public var printedSize: Int?
    public var digital: Bool
    public var foilOnly: Bool
    public var nonfoilOnly: Bool
    public var scryfallUri: String
    public var uri: String
    public var iconSvgUri: String
    public var searchUri: String

    public init(id: UUID,
                code: String,
                mtgoCode: String? = nil,
                tcgplayerId: Int? = nil,
                name: String,
                setType: MTGSet.`Type`,
                releasedAt: String? = nil,
                blockCode: String? = nil,
                block: String? = nil,
                parentSetCode: String? = nil,
                cardCount: Int,
                printedSize: Int? = nil,
                digital: Bool,
                foilOnly: Bool,
                nonfoilOnly: Bool,
                scryfallUri: String,
                uri: String,
                iconSvgUri: String,
                searchUri: String) {
        self.id = id
        self.code = code
        self.mtgoCode = mtgoCode
        self.tcgplayerId = tcgplayerId
        self.name = name
        self.setType = setType
        self.releasedAt = releasedAt
        self.blockCode = blockCode
        self.block = block
        self.parentSetCode = parentSetCode
        self.cardCount = cardCount
        self.printedSize = printedSize
        self.digital = digital
        self.foilOnly = foilOnly
        self.nonfoilOnly = nonfoilOnly
        self.scryfallUri = scryfallUri
        self.uri = uri
        self.iconSvgUri = iconSvgUri
        self.searchUri = searchUri
    }
}
