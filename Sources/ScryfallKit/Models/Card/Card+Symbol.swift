//
//  Card+Symbol.swift
//

import Foundation

extension Card {
  /// A symbol that could appear on a Magic: the Gathering card
  public struct Symbol: Codable, Identifiable, Sendable {
    /// The textual representation of this symbol
    public var symbol: String
    /// A more loose variation of the symbol.
    ///
    /// Example: "{W}" has a `looseVariant` of "W"
    public var looseVariant: String?
    /// An english description of this symbol's meaning
    public var english: String
    /// True if this symbol is transposable
    ///
    /// Scryfall doesn't provide any more information on what this means but inspecting which symbols are marked as transposable reveals that only hybrid and half mana symbols are transposable.
    public var transposable: Bool
    /// True if this symbol is a mana symbol
    public var representsMana: Bool
    /// The amount that this symbol adds to a card's converted mana cost
    public var cmc: Double?
    /// True if this symbol _could_ appear in a card's mana cost
    public var appearsInManaCosts: Bool
    /// True if this symbol is funny
    public var funny: Bool
    /// The colors that make up this symbol
    public var colors: [Color]
    /// Alternate notations for this symbol that used on Wizards of the Coast's [Gatherer](https://gatherer.wizards.com/Pages/Default.aspx)
    public var gathererAlternates: [String]?
    /// A link to an SVG of this symbol
    public var svgUri: String?

    /// A computed ID for this symbol which is just the `symbol` property
    public var id: String { symbol }

    public init(
      symbol: String,
      looseVariant: String? = nil,
      english: String,
      transposable: Bool,
      representsMana: Bool,
      cmc: Double? = nil,
      appearsInManaCosts: Bool,
      funny: Bool,
      colors: [Color],
      gathererAlternates: [String]? = nil,
      svgUri: String? = nil
    ) {
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
