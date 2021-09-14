//
//  Ruling.swift
//  ScryfallKit
//
//  Created by Jacob Hearst on 8/22/21.
//

import Foundation

public struct Ruling: Codable {
    public enum Identifier {
        case scryfallID(id: String)
        case mtgoID(id: Int)
        case multiverseID(id: Int)
        case arenaID(id: Int)
        case collectorNumberSet(collectorNumber: String, set: String)
    }

    public var source: String
    public var publishedAt: String
    public var comment: String
}
