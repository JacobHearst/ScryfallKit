//
//  Enums.swift
//  
//
//  Created by Jacob Hearst on 6/8/21.
//

import Foundation

public enum Color: String, Codable, CaseIterable {
    case W, U, B, R, G, C
}

public enum Layout: String, CaseIterable, Codable {
    case normal, split, flip, transform, meld, leveler, saga, adventure, planar, scheme, vanguard, token, emblem, augment, host, `class`
    case modalDfc = "modal_dfc"
    case doubleSided = "double_sided"
    case doubleFacedToken = "double_faced_token"
    case artSeries = "art_series"
}

public enum Legality: String, Codable, CaseIterable {
    case legal, restricted, banned
    case notLegal = "not_legal"

    public var label: String {
        switch self {
            case .notLegal: return "Not Legal"
            default: return rawValue.capitalized
        }
    }
}

public enum BorderColor: String, Codable, CaseIterable {
    case black, borderless, gold, silver, white
}

public enum Frame: String, Codable, CaseIterable {
    case v1993 = "1993"
    case v1997 = "1997"
    case v2003 = "2003"
    case v2015 = "2015"
    case future
}

public enum FrameEffect: String, Codable, CaseIterable {
    case legendary, miracle, nyxtouched, draft, devoid, tombstone, colorshifted, inverted, sunmoondfc, compasslanddfc, originpwdfc, mooneldrazidfc, waxingandwaningmoondfc, showcase, extendedart, companion, etched, snow, lesson
}

public enum Game: String, Codable, CaseIterable {
    case paper, mtgo, arena
}

public enum UniqueMode: String, Codable, CaseIterable {
    case cards, art, prints
}

public enum SortMode: String, Codable, CaseIterable {
    case name, set, released, rarity, color, usd, tix, eur, cmc, power, toughness, edhrec, artist
}

public enum SortDirection: String, Codable, CaseIterable {
    case auto, asc, desc
}

public enum Format: String, CaseIterable {
    case standard, historic, pioneer, modern, legacy, pauper, vintage, penny, commander, brawl
}
