//
//  CardPrices.swift
//  
//
//  Created by Jacob Hearst on 7/15/22.
//

import Foundation

public struct CardPrices: Codable, Hashable {
    public var tix: String?
    public var usd: String?
    public var usdFoil: String?
    public var eur: String?
    
    public init(tix: String? = nil, usd: String? = nil, usdFoil: String? = nil, eur: String? = nil) {
        self.tix = tix
        self.usd = usd
        self.usdFoil = usdFoil
        self.eur = eur
    }
}
