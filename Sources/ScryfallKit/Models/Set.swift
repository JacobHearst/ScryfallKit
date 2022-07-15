//
//  Set.swift
//  ScryfallKit
//
//  Created by Jacob Hearst on 8/22/21.
//

import Foundation

public struct Set: Codable, Identifiable {
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
        case core, expansion, masters, masterpiece, spellbook, commander, planechase, archenemy, vanguard, funny, starter, box, promo, token, memorabilia, arsenal, alchemy
        case fromTheVault = "from_the_vault"
        case premiumDeck = "premium_deck"
        case duelDeck = "duel_deck"
        case draftInnovation = "draft_innovation"
        case treasureChest = "treasure_chest"
    }

    public var id: UUID
    public var code: String
    public var mtgoCode: String?
    public var tcgplayerId: Int?
    public var name: String
    public var setType: Set.`Type`
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
                setType: Set.`Type`,
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
