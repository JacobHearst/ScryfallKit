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
    
    public init(cost: String, cmc: Double, colors: [Color], colorless: Bool, monocolored: Bool, multicolored: Bool) {
        self.cost = cost
        self.cmc = cmc
        self.colors = colors
        self.colorless = colorless
        self.monocolored = monocolored
        self.multicolored = multicolored
    }
}
