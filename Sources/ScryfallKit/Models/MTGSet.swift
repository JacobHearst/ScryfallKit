//
//  MTGSet.swift
//

import Foundation
import OSLog

/// A set represents a group of related Magic cards
///
/// [Scryfall documentation](https://scryfall.com/docs/api/sets)
public struct MTGSet: Codable, Identifiable, Hashable, Sendable {
    /// An value that can be used to identify a set
    public enum Identifier {
        case code(code: String)
        case scryfallID(id: String)
        case tcgPlayerID(id: String)

        var identifier: String {
            switch self {
            case .code(let code): return code
            case .scryfallID(let id): return id
            case .tcgPlayerID(let id): return id
            }
        }
    }

    /// A machine-readable value describing the type of set this is.
    ///
    /// See [Scryfall's docs](https://scryfall.com/docs/api/sets#set-types) for more information on set types
    public struct Kind: RawRepresentable, Codable, CaseIterable, Sendable, Equatable, Hashable {
        public static let core = Kind(rawValue: "core")
        public static let expansion = Kind(rawValue: "expansion")
        public static let masters = Kind(rawValue: "masters")
        public static let masterpiece = Kind(rawValue: "masterpiece")
        public static let spellbook = Kind(rawValue: "spellbook")
        public static let commander = Kind(rawValue: "commander")
        public static let planechase = Kind(rawValue: "planechase")
        public static let archenemy = Kind(rawValue: "archenemy")
        public static let vanguard = Kind(rawValue: "vanguard")
        public static let funny = Kind(rawValue: "funny")
        public static let starter = Kind(rawValue: "starter")
        public static let box = Kind(rawValue: "box")
        public static let promo = Kind(rawValue: "promo")
        public static let token = Kind(rawValue: "token")
        public static let memorabilia = Kind(rawValue: "memorabilia")
        public static let arsenal = Kind(rawValue: "arsenal")
        public static let alchemy = Kind(rawValue: "alchemy")
        public static let minigame = Kind(rawValue: "minigame")
        public static let eternal = Kind(rawValue: "eternal")
        public static let fromTheVault = Kind(rawValue: "from_the_vault")
        public static let premiumDeck = Kind(rawValue: "premium_deck")
        public static let duelDeck = Kind(rawValue: "duel_deck")
        public static let draftInnovation = Kind(rawValue: "draft_innovation")
        public static let treasureChest = Kind(rawValue: "treasure_chest")

        public static let allCases: [Kind] = [
            .core, .expansion, .masters, .masterpiece, .spellbook, .commander, .planechase,
            .archenemy, .vanguard, .funny, .starter, .box, .promo, .token, .memorabilia, .arsenal,
            .alchemy, .minigame, .eternal, .fromTheVault, .premiumDeck, .duelDeck, .draftInnovation,
            .treasureChest,
        ]

        public let rawValue: String

        public init(rawValue: String) { self.rawValue = rawValue }
    }

    /// A unique ID for this set on Scryfall that will not change.
    public var id: UUID
    /// The unique three to five-letter code for this set.
    public var code: String
    /// The unique code for this set on MTGO, which may differ from the regular code.
    public var mtgoCode: String?
    /// The unique code for this set on MTG Arena, which may differ from the regular code.
    public var arenaCode: String?
    /// This set’s ID on [TCGplayer’s API](https://docs.tcgplayer.com/docs), also known as the groupId.
    public var tcgplayerId: Int?
    /// The English name of the set.
    public var name: String
    /// A computer-readable classification for this set.
    public var setType: Kind
    /// The date the set was released or the first card was printed in the set (in GMT-8 Pacific time).
    public var releasedAt: String?
    /// The block code for this set, if any.
    public var blockCode: String?
    /// The block or group name code for this set, if any.
    public var block: String?
    /// The set code for the parent set, if any. promo and token sets often have a parent set.
    public var parentSetCode: String?
    /// The number of cards in this set.
    public var cardCount: Int
    /// The denominator for the set’s printed collector numbers.
    public var printedSize: Int?
    /// True if this set was only released in a video game.
    public var digital: Bool
    /// True if this set contains only foil cards.
    public var foilOnly: Bool
    /// True if this set contains only nonfoil cards.
    public var nonfoilOnly: Bool
    /// A link to this set’s permapage on Scryfall’s website.
    public var scryfallUri: String
    /// A link to this set object on Scryfall’s API.
    public var uri: String
    /// A URI to an SVG file for this set’s icon on Scryfall’s CDN.
    ///
    /// - Note: Hotlinking this image isn’t recommended, because it may change slightly over time. You should download it and use it locally for your particular user interface needs.
    public var iconSvgUri: String
    /// A Scryfall API URI that you can request to begin paginating over the cards in this set.
    public var searchUri: String

    public init(
        id: UUID,
        code: String,
        mtgoCode: String? = nil,
        arenaCode: String? = nil,
        tcgplayerId: Int? = nil,
        name: String,
        setType: Kind,
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
        searchUri: String
    ) {
        self.id = id
        self.code = code
        self.mtgoCode = mtgoCode
        self.arenaCode = arenaCode
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
