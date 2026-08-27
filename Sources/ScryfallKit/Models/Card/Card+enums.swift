//
//  Card+enums.swift
//

import Foundation
import OSLog

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
  public enum Finish: RawRepresentable, Codable, CaseIterable, Sendable, Equatable, Hashable {
    case nonfoil, foil, etched, glossy
    /// A finish that hasn't been added to ScryfallKit yet
    case unknown(String)

    /// All known finishes
    public static let allCases: [Card.Finish] = [.nonfoil, .foil, .etched, .glossy]

    public var rawValue: String {
      switch self {
      case .unknown(let unknownRawValue): unknownRawValue
      default: String(describing: self)
      }
    }
  }

  /// Status of Scryfall's image asset for this card
  ///
  /// [Scryfall documentation](https://scryfall.com/docs/api/images#image-statuses)
  public enum ImageStatus: String, Codable, CaseIterable, Sendable {
    case missing, placeholder, lowres
    case highresScan = "highres_scan"
  }

  /// Types of images provided by Scryfall
  ///
  /// [Scryfall documentation](https://scryfall.com/docs/api/images)
  public enum ImageType: String, Codable, CaseIterable {
    case png, large, normal, small
    case artCrop = "art_crop"
    case borderCrop = "border_crop"
  }

  /// Card rarities
  public enum Rarity: String, Codable, CaseIterable, Comparable, Sendable {
    case common, uncommon, rare, special, mythic, bonus

    /// Order according to Scryfall
    public static func < (lhs: Card.Rarity, rhs: Card.Rarity) -> Bool {
      let order: [Card.Rarity] = [.bonus, .special, .common, .uncommon, .rare, .mythic]
      return order.firstIndex(of: lhs)! < order.firstIndex(of: rhs)!
    }
  }

  /// The security stamp printed on a card
  public enum SecurityStamp: RawRepresentable, Codable, CaseIterable, Sendable, Equatable, Hashable
  {
    case oval, triangle, acorn, circle, arena, heart
    /// A security stamp that hasn't been added to ScryfallKit yet
    case unknown(String)

    /// All known security stamps
    public static let allCases: [Card.SecurityStamp] = [
      .oval, .triangle, .acorn, .circle, .arena, .heart,
    ]

    public var rawValue: String {
      switch self {
      case .unknown(let unknownRawValue): unknownRawValue
      default: String(describing: self)
      }
    }
  }

  /// Layouts for a Magic card
  ///
  /// [Scryfall documentation](https://scryfall.com/docs/api/layouts)
  public enum Layout: RawRepresentable, CaseIterable, Codable, Sendable, Equatable, Hashable {
    case normal, split, flip, transform, meld, leveler, saga, adventure, planar, scheme, vanguard,
         token, emblem, augment, host, `class`, battle, `case`, mutate, prototype, prepare, modalDfc, doubleSided, doubleFacedToken, artSeries, reversibleCard, frontCard

    /// A layout that hasn't been added to ScryfallKit yet
    case unknown(String)

    /// All known Magic: the Gathering card layouts
    public static let allCases: [Card.Layout] = [
      .normal, .split, .flip, .transform, .meld, .leveler, .saga, .adventure, .planar, .scheme, .vanguard, .token, .emblem, .augment, .host, .class, .battle, .case, .mutate, .prototype, .prepare, .modalDfc, .doubleSided, .doubleFacedToken, .artSeries, .reversibleCard, .frontCard,
    ]

    public var rawValue: String {
      switch self {
      case .modalDfc: "modal_dfc"
      case .doubleSided: "double_sided"
      case .doubleFacedToken: "double_faced_token"
      case .artSeries: "art_series"
      case .frontCard: "front_card"
      case .reversibleCard: "reversible_card"
      case .unknown(let string): string
      default: String(describing: self)
      }
    }
  }

  /// Machine-readable strings representing a card's legality in different formats
  public enum Legality: String, Codable, CaseIterable, Hashable, Sendable {
    /// This card is legal to be played in this format
    case legal
    /// This card is restricted in this format (players may only have one copy in their deck)
    case restricted
    /// This card has been banned in this format
    case banned
    /// This card is not legal in this format (ex: an uncommon is not legal in pauper)
    case notLegal = "not_legal"

    public var label: String {
      switch self {
      case .notLegal:
        return "Not Legal"
      default:
        return rawValue.capitalized
      }
    }
  }

  /// A string representing one of the colors (and colorless) in Magic
  public enum Color: String, Codable, CaseIterable, Comparable, Sendable {
    // swiftlint:disable:next identifier_name
    case W, U, B, R, G, C

    public static func < (lhs: Color, rhs: Color) -> Bool {
      let order: [Color] = [.W, .U, .B, .R, .G, .C]
      return order.firstIndex(of: lhs)! < order.firstIndex(of: rhs)!
    }
  }

  /// A value that a card can produce, as reported by `producedMana`
  ///
  /// As of this writing, only one card (Unfinity's Sole Performer) can produce "mana" that isn't a
  /// normal color, so this enumeration is split from the core Color enumeration for convenience in
  /// the overwhelmingly common cases.
  public enum ProducedColor: RawRepresentable, Codable, CaseIterable, Sendable, Equatable, Hashable
  {
    // swiftlint:disable:next identifier_name
    case W, U, B, R, G, C
    /// A produced value that isn't a color, or that hasn't been added to ScryfallKit yet
    case unknown(String)

    /// All the produced values that are also colors, in the order Scryfall sorts them
    public static let allCases: [Card.ProducedColor] = [.W, .U, .B, .R, .G, .C]

    public var rawValue: String {
      switch self {
      case .unknown(let unknownRawValue): unknownRawValue
      default: String(describing: self)
      }
    }

    /// The equivalent ``Card/Color``, or nil if this value isn't one of Magic's colors
    public var color: Color? { Color(rawValue: rawValue) }
  }

  /// Card border colors
  public enum BorderColor: RawRepresentable, Codable, CaseIterable, Sendable, Equatable, Hashable {
    case black, borderless, gold, silver, white, yellow
    /// A border color that hasn't been added to ScryfallKit yet
    case unknown(String)

    /// All known border colors
    public static let allCases: [Card.BorderColor] = [
      .black, .borderless, .gold, .silver, .white, .yellow,
    ]

    public var rawValue: String {
      switch self {
      case .unknown(let unknownRawValue): unknownRawValue
      default: String(describing: self)
      }
    }
  }

  /// Card frames
  ///
  /// [Scryfall documentation](https://scryfall.com/docs/api/frames)
  public enum Frame: RawRepresentable, Codable, CaseIterable, Sendable, Equatable, Hashable {
    case v1993, v1997, v2003, v2015, future
    /// A frame that hasn't been added to ScryfallKit yet
    case unknown(String)

    /// All known frames
    public static let allCases: [Card.Frame] = [.v1993, .v1997, .v2003, .v2015, .future]

    public var rawValue: String {
      switch self {
      case .v1993: "1993"
      case .v1997: "1997"
      case .v2003: "2003"
      case .v2015: "2015"
      case .unknown(let unknownRawValue): unknownRawValue
      default: String(describing: self)
      }
    }
  }

  /// Effects applied to a Magic card frame
  ///
  /// [Scryfall documentation](https://scryfall.com/docs/api/frames#frame-effects)
  public enum FrameEffect: RawRepresentable, Codable, Sendable, CaseIterable, Equatable, Hashable {
    case legendary, miracle, draft, devoid, tombstone, showcase, companion, etched, snow, lesson, battle, gravestone, vehicle, borderless, extended, spree, textless, enchantment, inverted
    case nyxTouched
    case colorShifted
    case sunMoonDfc
    case compassLandDfc
    case originPwDfc
    case moonEldraziDfc
    case waxingAndWaningMoonDfc
    case extendedArt
    case convertDfc
    case fAndFc
    case fullArt
    case shatteredGlass
    case upsideDownDfc
    /// A layout that hasn't been added to ScryfallKit yet
    case unknown(String)

    /// All known Magic: the Gathering frame effects
    public static let allCases: [Card.FrameEffect] = [
      .legendary, .miracle, .nyxTouched, .draft, .devoid, .tombstone, .colorShifted, .inverted,
        .sunMoonDfc, .compassLandDfc, .originPwDfc, .moonEldraziDfc, .waxingAndWaningMoonDfc, .showcase,
        .extendedArt, .companion, .etched, .snow, .lesson, .convertDfc, .fAndFc, .battle, .gravestone, .fullArt,
        .vehicle, .borderless, .extended, .spree, .textless, .enchantment, .shatteredGlass, .upsideDownDfc,
    ]

    public var rawValue: String {
      switch self {
      case .unknown(let unknownRawValue): unknownRawValue
      case .nyxTouched: "nyxtouched"
      case .colorShifted: "colorshifted"
      case .sunMoonDfc: "sunmoondfc"
      case .compassLandDfc: "compasslanddfc"
      case .originPwDfc: "originpwdfc"
      case .moonEldraziDfc: "mooneldrazidfc"
      case .waxingAndWaningMoonDfc: "waxingandwaningmoondfc"
      case .extendedArt: "extendedart"
      case .convertDfc: "convertdfc"
      case .fAndFc: "fandfc"
      case .fullArt: "fullart"
      case .shatteredGlass: "shatteredglass"
      case .upsideDownDfc: "upsidedowndfc"
      default: String(describing: self)
      }
    }
  }
}
