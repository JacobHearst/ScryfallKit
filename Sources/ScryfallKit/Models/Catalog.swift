//
//  File.swift
//  
//
//  Created by Jacob Hearst on 6/9/21.
//

import Foundation

public struct Catalog: Codable {
    public enum `Type`: String, Codable, CaseIterable {
        case powers, toughnesses, loyalties, watermarks
        case cardNames = "card-names"
        case artistNames = "artist-names"
        case wordBank = "word-bank"
        case creatureTypes = "creature-types"
        case planeswalkerTypes = "planeswalker-types"
        case landTypes = "land-types"
        case artifactTypes = "artifact-types"
        case enchantmentTypes = "enchantment-types"
        case spellTypes = "spell-types"
        case keywordAbilities = "keyword-abilities"
        case keywordActions = "keyword-actions"
        case abilityWords = "ability-words"
    }

    public var uri: String?
    public var totalValues: Int
    public var data: [String]
    
    public init(uri: String? = nil, totalValues: Int, data: [String]) {
        self.uri = uri
        self.totalValues = totalValues
        self.data = data
    }
}
