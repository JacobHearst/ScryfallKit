//
//  Symbol.swift
//  ScryfallKit
//
//  Created by Jacob Hearst on 8/22/21.
//

import Foundation

public struct CardSymbol: Codable {
    public var symbol: String
    public var looseVariant: String?
    public var english: String
    public var transposable: Bool
    public var representsMana: Bool
    public var cmc: Double?
    public var appearsInManaCosts: Bool
    public var funny: Bool
    public var colors: [Color]
    public var gathererAlternates: [String]?
    public var svgUri: String?
}
