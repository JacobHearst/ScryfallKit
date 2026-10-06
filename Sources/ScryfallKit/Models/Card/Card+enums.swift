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
  public struct Finish: RawRepresentable, Codable, CaseIterable, Sendable, Equatable, Hashable {
    public static let nonfoil = Finish(rawValue: "nonfoil")
    public static let foil = Finish(rawValue: "foil")
    public static let etched = Finish(rawValue: "etched")
    public static let glossy = Finish(rawValue: "glossy")

    public static let allCases: [Finish] = [
      .nonfoil,
      .foil,
      .etched,
      .glossy,
    ]

    public let rawValue: String

    public init(rawValue: String) {
      self.rawValue = rawValue
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
  public struct SecurityStamp: RawRepresentable, Codable, CaseIterable, Sendable, Equatable,
    Hashable
  {
    public static let oval = SecurityStamp(rawValue: "oval")
    public static let triangle = SecurityStamp(rawValue: "triangle")
    public static let acorn = SecurityStamp(rawValue: "acorn")
    public static let circle = SecurityStamp(rawValue: "circle")
    public static let arena = SecurityStamp(rawValue: "arena")
    public static let heart = SecurityStamp(rawValue: "heart")

    public static let allCases: [SecurityStamp] = [
      .oval,
      .triangle,
      .acorn,
      .circle,
      .arena,
      .heart,
    ]

    public let rawValue: String

    public init(rawValue: String) {
      self.rawValue = rawValue
    }
  }

  /// Layouts for a Magic card
  ///
  /// [Scryfall documentation](https://scryfall.com/docs/api/layouts)
  public struct Layout: RawRepresentable, Codable, CaseIterable, Sendable, Equatable, Hashable {
    public static let normal = Layout(rawValue: "normal")
    public static let split = Layout(rawValue: "split")
    public static let flip = Layout(rawValue: "flip")
    public static let transform = Layout(rawValue: "transform")
    public static let meld = Layout(rawValue: "meld")
    public static let leveler = Layout(rawValue: "leveler")
    public static let saga = Layout(rawValue: "saga")
    public static let adventure = Layout(rawValue: "adventure")
    public static let planar = Layout(rawValue: "planar")
    public static let scheme = Layout(rawValue: "scheme")
    public static let vanguard = Layout(rawValue: "vanguard")
    public static let token = Layout(rawValue: "token")
    public static let emblem = Layout(rawValue: "emblem")
    public static let augment = Layout(rawValue: "augment")
    public static let host = Layout(rawValue: "host")
    public static let `class` = Layout(rawValue: "class")
    public static let battle = Layout(rawValue: "battle")
    public static let `case` = Layout(rawValue: "case")
    public static let mutate = Layout(rawValue: "mutate")
    public static let prototype = Layout(rawValue: "prototype")
    public static let prepare = Layout(rawValue: "prepare")
    public static let modalDfc = Layout(rawValue: "modal_dfc")
    public static let doubleSided = Layout(rawValue: "double_sided")
    public static let doubleFacedToken = Layout(rawValue: "double_faced_token")
    public static let artSeries = Layout(rawValue: "art_series")
    public static let reversibleCard = Layout(rawValue: "reversible_card")
    public static let frontCard = Layout(rawValue: "front_card")

    public static let allCases: [Layout] = [
      .normal,
      .split,
      .flip,
      .transform,
      .meld,
      .leveler,
      .saga,
      .adventure,
      .planar,
      .scheme,
      .vanguard,
      .token,
      .emblem,
      .augment,
      .host,
      .`class`,
      .battle,
      .`case`,
      .mutate,
      .prototype,
      .prepare,
      .modalDfc,
      .doubleSided,
      .doubleFacedToken,
      .artSeries,
      .reversibleCard,
      .frontCard,
    ]

    public let rawValue: String

    public init(rawValue: String) {
      self.rawValue = rawValue
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
  public struct ProducedColor: RawRepresentable, Codable, CaseIterable, Sendable, Equatable,
    Hashable
  {
    public static let W = ProducedColor(rawValue: "W")
    public static let U = ProducedColor(rawValue: "U")
    public static let B = ProducedColor(rawValue: "B")
    public static let R = ProducedColor(rawValue: "R")
    public static let G = ProducedColor(rawValue: "G")
    public static let C = ProducedColor(rawValue: "C")

    public static let allCases: [ProducedColor] = [
      .W,
      .U,
      .B,
      .R,
      .G,
      .C,
    ]

    public let rawValue: String

    public init(rawValue: String) {
      self.rawValue = rawValue
    }

    /// The equivalent ``Card/Color``, or nil if this value isn't one of Magic's colors
    public var color: Color? { Color(rawValue: rawValue) }
  }

  /// Card border colors
  public struct BorderColor: RawRepresentable, Codable, CaseIterable, Sendable, Equatable, Hashable
  {
    public static let black = BorderColor(rawValue: "black")
    public static let borderless = BorderColor(rawValue: "borderless")
    public static let gold = BorderColor(rawValue: "gold")
    public static let silver = BorderColor(rawValue: "silver")
    public static let white = BorderColor(rawValue: "white")
    public static let yellow = BorderColor(rawValue: "yellow")

    public static let allCases: [BorderColor] = [
      .black,
      .borderless,
      .gold,
      .silver,
      .white,
      .yellow,
    ]

    public let rawValue: String

    public init(rawValue: String) {
      self.rawValue = rawValue
    }
  }

  /// Card frames
  ///
  /// [Scryfall documentation](https://scryfall.com/docs/api/frames)
  public struct Frame: RawRepresentable, Codable, CaseIterable, Sendable, Equatable, Hashable {
    public static let v1993 = Frame(rawValue: "1993")
    public static let v1997 = Frame(rawValue: "1997")
    public static let v2003 = Frame(rawValue: "2003")
    public static let v2015 = Frame(rawValue: "2015")
    public static let future = Frame(rawValue: "future")

    public static let allCases: [Frame] = [
      .v1993,
      .v1997,
      .v2003,
      .v2015,
      .future,
    ]

    public let rawValue: String

    public init(rawValue: String) {
      self.rawValue = rawValue
    }
  }

  /// Effects applied to a Magic card frame
  ///
  /// [Scryfall documentation](https://scryfall.com/docs/api/frames#frame-effects)
  public struct FrameEffect: RawRepresentable, Codable, CaseIterable, Sendable, Equatable, Hashable
  {
    public static let legendary = FrameEffect(rawValue: "legendary")
    public static let miracle = FrameEffect(rawValue: "miracle")
    public static let draft = FrameEffect(rawValue: "draft")
    public static let devoid = FrameEffect(rawValue: "devoid")
    public static let tombstone = FrameEffect(rawValue: "tombstone")
    public static let showcase = FrameEffect(rawValue: "showcase")
    public static let companion = FrameEffect(rawValue: "companion")
    public static let etched = FrameEffect(rawValue: "etched")
    public static let snow = FrameEffect(rawValue: "snow")
    public static let lesson = FrameEffect(rawValue: "lesson")
    public static let battle = FrameEffect(rawValue: "battle")
    public static let gravestone = FrameEffect(rawValue: "gravestone")
    public static let vehicle = FrameEffect(rawValue: "vehicle")
    public static let borderless = FrameEffect(rawValue: "borderless")
    public static let extended = FrameEffect(rawValue: "extended")
    public static let spree = FrameEffect(rawValue: "spree")
    public static let textless = FrameEffect(rawValue: "textless")
    public static let enchantment = FrameEffect(rawValue: "enchantment")
    public static let inverted = FrameEffect(rawValue: "inverted")
    public static let nyxTouched = FrameEffect(rawValue: "nyxtouched")
    public static let colorShifted = FrameEffect(rawValue: "colorshifted")
    public static let sunMoonDfc = FrameEffect(rawValue: "sunmoondfc")
    public static let compassLandDfc = FrameEffect(rawValue: "compasslanddfc")
    public static let originPwDfc = FrameEffect(rawValue: "originpwdfc")
    public static let moonEldraziDfc = FrameEffect(rawValue: "mooneldrazidfc")
    public static let waxingAndWaningMoonDfc = FrameEffect(rawValue: "waxingandwaningmoondfc")
    public static let extendedArt = FrameEffect(rawValue: "extendedart")
    public static let convertDfc = FrameEffect(rawValue: "convertdfc")
    public static let fAndFc = FrameEffect(rawValue: "fandfc")
    public static let fullArt = FrameEffect(rawValue: "fullart")
    public static let shatteredGlass = FrameEffect(rawValue: "shatteredglass")
    public static let upsideDownDfc = FrameEffect(rawValue: "upsidedowndfc")

    public static let allCases: [FrameEffect] = [
      .legendary,
      .miracle,
      .draft,
      .devoid,
      .tombstone,
      .showcase,
      .companion,
      .etched,
      .snow,
      .lesson,
      .battle,
      .gravestone,
      .vehicle,
      .borderless,
      .extended,
      .spree,
      .textless,
      .enchantment,
      .inverted,
      .nyxTouched,
      .colorShifted,
      .sunMoonDfc,
      .compassLandDfc,
      .originPwDfc,
      .moonEldraziDfc,
      .waxingAndWaningMoonDfc,
      .extendedArt,
      .convertDfc,
      .fAndFc,
      .fullArt,
      .shatteredGlass,
      .upsideDownDfc,
    ]

    public let rawValue: String

    public init(rawValue: String) {
      self.rawValue = rawValue
    }
  }
}
