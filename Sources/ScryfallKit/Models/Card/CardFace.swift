//
//  CardFace.swift
//  
//
//  Created by Jacob Hearst on 7/15/22.
//

import Foundation

public struct CardFace: Codable, Hashable {
    public var artist: String?
    public var colorIndicator: [Color]?
    public var colors: [Color]?
    public var flavorText: String?
    public var illustrationId: UUID?
    public var imageUris: ImageUris?
    public var loyalty: String?
    public var manaCost: String
    public var name: String
    public var oracleText: String?
    public var power: String?
    public var printedName: String?
    public var printedText: String?
    public var printedTypeLine: String?
    public var toughness: String?
    public var typeLine: String? // Tokens don't have type lines
    public var watermark: String?
    
    public init(artist: String? = nil,
         colorIndicator: [Color]? = nil,
         colors: [Color]? = nil,
         flavorText: String? = nil,
         illustrationId: UUID? = nil,
         imageUris: ImageUris? = nil,
         loyalty: String? = nil,
         manaCost: String,
         name: String,
         oracleText: String? = nil,
         power: String? = nil,
         printedName: String? = nil,
         printedText: String? = nil,
         printedTypeLine: String? = nil,
         toughness: String? = nil,
         typeLine: String? = nil,
         watermark: String? = nil) {
        self.artist = artist
        self.colorIndicator = colorIndicator
        self.colors = colors
        self.flavorText = flavorText
        self.illustrationId = illustrationId
        self.imageUris = imageUris
        self.loyalty = loyalty
        self.manaCost = manaCost
        self.name = name
        self.oracleText = oracleText
        self.power = power
        self.printedName = printedName
        self.printedText = printedText
        self.printedTypeLine = printedTypeLine
        self.toughness = toughness
        self.typeLine = typeLine
        self.watermark = watermark
    }
}
