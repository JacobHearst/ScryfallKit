//
//  ManaCost.swift
//  ScryfallKit
//
//  Created by Jacob Hearst on 8/22/21.
//

import Foundation

public struct ManaCost: Codable {
    public var cost: String
    public var cmc: Double
    public var colors: [Color]
    public var colorless: Bool
    public var monocolored: Bool
    public var multicolored: Bool
}
