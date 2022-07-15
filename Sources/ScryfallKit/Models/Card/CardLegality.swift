//
//  CardLegality.swift
//  
//
//  Created by Jacob Hearst on 7/15/22.
//

import Foundation

public struct CardLegality: Codable, Hashable {
    public let standard: Legality?
    public let historic: Legality?
    public let pioneer: Legality?
    public let modern: Legality?
    public let legacy: Legality?
    public let pauper: Legality?
    public let vintage: Legality?
    public let penny: Legality?
    public let commander: Legality?
    public let brawl: Legality?
    
    public init(standard: Legality?,
         historic: Legality?,
         pioneer: Legality?,
         modern: Legality?,
         legacy: Legality?,
         pauper: Legality?,
         vintage: Legality?,
         penny: Legality?,
         commander: Legality?,
         brawl: Legality?) {
        self.standard = standard
        self.historic = historic
        self.pioneer = pioneer
        self.modern = modern
        self.legacy = legacy
        self.pauper = pauper
        self.vintage = vintage
        self.penny = penny
        self.commander = commander
        self.brawl = brawl
    }
}
