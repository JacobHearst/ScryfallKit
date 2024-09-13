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
      case .code(let code):
        return code
      case .scryfallID(let id):
        return id
      case .tcgPlayerID(let id):
        return id
      }
    }
  }

  /// A machine-readable value describing the type of set this is.
  ///
  /// See [Scryfall's docs](https://scryfall.com/docs/api/sets#set-types) for more information on set types
  public enum `Type`: String, Codable, Sendable {
    // While "masters" is in fact not inclusive, it's also a name that we can't control
    // swiftlint:disable:next inclusive_language
    case core, expansion, masters, masterpiece, spellbook, commander, planechase, archenemy,
      vanguard, funny, starter, box, promo, token, memorabilia, arsenal, alchemy, minigame, unknown
    case fromTheVault = "from_the_vault"
    case premiumDeck = "premium_deck"
    case duelDeck = "duel_deck"
    case draftInnovation = "draft_innovation"
    case treasureChest = "treasure_chest"

    public init(from decoder: Decoder) throws {
      self = try Self(rawValue: decoder.singleValueContainer().decode(RawValue.self)) ?? .unknown
      if self == .unknown, let rawValue = try? String(from: decoder) {
        if #available(iOS 14.0, macOS 11.0, *) {
          Logger.main.warning("Decoded unknown MTGSet Type: \(rawValue)")
        } else {
          print("Decoded unknown MTGSet Type: \(rawValue)")
        }
      }
    }
  }

  /// A unique ID for this set on Scryfall that will not change.
  public var id: UUID
  /// The unique three to five-letter code for this set.
  public var code: String
  /// The unique code for this set on MTGO, which may differ from the regular code.
  public var mtgoCode: String?
  /// This set’s ID on [TCGplayer’s API](https://docs.tcgplayer.com/docs), also known as the groupId.
  public var tcgplayerId: Int?
  /// The English name of the set.
  public var name: String
  /// A computer-readable classification for this set.
  public var setType: MTGSet.`Type`
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
    searchUri: String
  ) {
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
