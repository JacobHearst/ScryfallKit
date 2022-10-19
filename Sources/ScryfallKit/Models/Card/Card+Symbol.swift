//
//  Card+Symbol.swift
//

import Foundation

extension Card {
    public struct Symbol: Codable, Identifiable {
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

        public var id: String { symbol }

        public init(symbol: String,
                    looseVariant: String? = nil,
                    english: String,
                    transposable: Bool,
                    representsMana: Bool,
                    cmc: Double? = nil,
                    appearsInManaCosts: Bool,
                    funny: Bool,
                    colors: [Color],
                    gathererAlternates: [String]? = nil,
                    svgUri: String? = nil) {
            self.symbol = symbol
            self.looseVariant = looseVariant
            self.english = english
            self.transposable = transposable
            self.representsMana = representsMana
            self.cmc = cmc
            self.appearsInManaCosts = appearsInManaCosts
            self.funny = funny
            self.colors = colors
            self.gathererAlternates = gathererAlternates
            self.svgUri = svgUri
        }
    }
}
