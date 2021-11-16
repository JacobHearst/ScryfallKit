//
//  File.swift
//  
//
//  Created by Jacob Hearst on 11/16/21.
//

public enum ComparisonType: String {
    case lessThan = "<"
    case lessThanOrEqual = "<="
    case greaterThan = ">"
    case greaterThanOrEqual = ">="
    case equal = "="
    case notEqual = "!="
    case including = ":"
}

public protocol FieldFilter {
    var filterString: String { get }
}

public enum CompoundCardFieldFilter: FieldFilter {
    case and([FieldFilter])
    case or([FieldFilter])

    public var filterString: String {
        switch self {
        case .and(let filters):
            return "(\(filters.map { $0.filterString }.joined(separator: " and ")))"
        case .or(let filters):
            return "(\(filters.map { $0.filterString }.joined(separator: " or ")))"
        }
    }
}

public enum CardFieldFilter: FieldFilter {
    // Colors and Identity
    case colors(String, ComparisonType = .including)
    case colorIdentity(String, ComparisonType = .including)

    // Types and oracle text
    case cardType(String)
    case cardText(String)

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
    case border(BorderColor)
    case frame(Frame)

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

    public var filterString: String {
        switch self {
        case .name(let value):
            return "name:\(value)"
        case .colors(let value, let comparison):
            return "color\(comparison.rawValue)\(value)"
        case .colorIdentity(let value, let comparison):
            return "identity\(comparison.rawValue)\(value)"
        case .cardType(let value):
            return "type:\(value)"
        case .cardText(let value):
            return "oracle\(value)"
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
}
