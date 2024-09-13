//
//  FieldFilter.swift
//

/// A comparison operator for card metadata
public enum ComparisonType: String, CaseIterable, Codable {
  case lessThan = "<"
  case lessThanOrEqual = "<="
  case greaterThan = ">"
  case greaterThanOrEqual = ">="
  case equal = "="
  case notEqual = "!="
  case including = ":"
}

/// An enum representing a search filter
public enum CardFieldFilter {
  // Colors and Identity
  case colors(String, ComparisonType = .including)
  case colorIdentity(String, ComparisonType = .including)

  // Types and oracle text
  case type(String)
  case oracleText(String)
  case fullOracleText(String)
  case oracleId(String)
  case keyword(String)

  // Mana costs
  case mana(String, ComparisonType = .equal)
  case devotion(String, ComparisonType = .equal)
  case produces(String, ComparisonType = .equal)
  case cmc(String, ComparisonType = .equal)

  // Power, toughness, and Loyalty
  case power(String, ComparisonType = .equal)
  case toughness(String, ComparisonType = .equal)
  case loyalty(String, ComparisonType = .equal)

  // Sets and Blocks
  case set(String)
  case block(String)
  case collectorNumber(String, ComparisonType = .equal)

  // Format based filters
  case format(String)
  case banned(String)
  case restricted(String)

  // Prices
  case usd(String, ComparisonType = .equal)
  case tix(String, ComparisonType = .equal)
  case eur(String, ComparisonType = .equal)

  // Artist, flavor text, and watermark
  case artist(String)
  case flavor(String)
  case watermark(String)

  // Border, Frame
  case border(Card.BorderColor)
  case frame(Card.Frame)

  // Tagger tags
  case art(String)
  case function(String)

  // Misc
  case name(String)
  case cube(String)
  case game(Game)
  case year(String, ComparisonType = .equal)
  case language(String)
  case `is`(String)
  case not(String)
  case include(String)
  case rarity(String, ComparisonType = .equal)
  case `in`(String)
  case compoundOr([CardFieldFilter])
  case compoundAnd([CardFieldFilter])

  /// The Scryfall syntax query string representing the filter
  public var filterString: String {
    switch self {
    case .fullOracleText(let value):
      return "fo:\(value)"
    case .oracleId(let id):
      return "oracleid:\(id)"
    case .keyword(let value):
      return "keyword:\(value)"
    case .compoundOr(let filters):
      return "(\(filters.map { $0.filterString }.joined(separator: " or ")))"
    case .compoundAnd(let filters):
      return "(\(filters.map { $0.filterString }.joined(separator: " and ")))"
    case .name(let value):
      return "name:\(value)"
    case .colors(let value, let comparison):
      return "color\(comparison.rawValue)\(value)"
    case .colorIdentity(let value, let comparison):
      return "identity\(comparison.rawValue)\(value)"
    case .type(let value):
      return "type:\(value)"
    case .oracleText(let value):
      return "oracle:\(value)"
    case .mana(let value, let comparison):
      return "mana\(comparison.rawValue)\(value)"
    case .devotion(let value, let comparison):
      return "devotion\(comparison.rawValue)\(value)"
    case .produces(let value, let comparison):
      return "produces\(comparison.rawValue)\(value)"
    case .cmc(let value, let comparison):
      return "cmc\(comparison.rawValue)\(value)"
    case .power(let value, let comparison):
      return "power\(comparison.rawValue)\(value)"
    case .toughness(let value, let comparison):
      return "toughness\(comparison.rawValue)\(value)"
    case .loyalty(let value, let comparison):
      return "loyalty\(comparison.rawValue)\(value)"
    case .set(let value):
      return "set:\(value)"
    case .block(let value):
      return "block:\(value)"
    case .collectorNumber(let value, let comparison):
      return "collectorNumber\(comparison.rawValue)\(value)"
    case .format(let value):
      return "format:\(value)"
    case .banned(let value):
      return "banned:\(value)"
    case .restricted(let value):
      return "restricted:\(value)"
    case .usd(let value, let comparison):
      return "usd\(comparison.rawValue)\(value)"
    case .tix(let value, let comparison):
      return "tix\(comparison.rawValue)\(value)"
    case .eur(let value, let comparison):
      return "eur\(comparison.rawValue)\(value)"
    case .artist(let value):
      return "artist:\(value)"
    case .flavor(let value):
      return "flavor:\(value)"
    case .watermark(let value):
      return "watermark:\(value)"
    case .border(let value):
      return "border:\(value)"
    case .frame(let value):
      return "frame:\(value)"
    case .art(let value):
      return "art:\(value)"
    case .function(let value):
      return "function:\(value)"
    case .cube(let value):
      return "cube:\(value)"
    case .game(let value):
      return "game:\(value)"
    case .year(let value, let comparison):
      return "year\(comparison.rawValue)\(value)"
    case .language(let value):
      return "language:\(value)"
    case .is(let value):
      return "is:\(value)"
    case .not(let value):
      return "not:\(value)"
    case .include(let value):
      return "include:\(value)"
    case .rarity(let value, let comparison):
      return "rarity\(comparison.rawValue)\(value)"
    case .in(let value):
      return "in:\(value)"
    }
  }

  /// The Scryfall syntax query string representing the filter, negated
  public var negated: String {
    "-\(filterString)"
  }
}
