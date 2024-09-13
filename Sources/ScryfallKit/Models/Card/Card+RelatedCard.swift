//
//  Card+RelatedCard.swift
//

import Foundation

extension Card {
  /// A Magic card that's related to another Magic card
  ///
  /// - Note: In the documentation of this struct, "this card" will refer to the `RelatedCard` object while "the original card" will refer to the `Card` object that contains this object
  public struct RelatedCard: Codable, Hashable, Sendable {
    /// The type of relationship
    public enum Component: String, Codable, CaseIterable, Hashable, Sendable {
      /// This card is a token that's made by the original card
      case token
      /// This card melds with the original card
      case meldPart = "meld_part"
      /// This card is the result of melding the original card with its other half
      case meldResult = "meld_result"
      /// This card combos with the original card
      case comboPiece = "combo_piece"
    }

    /// The Scryfall ID of this card
    public var id: UUID
    /// The type of relationship this card has to the original card
    public var component: Component
    /// The name of this card
    public var name: String
    /// The space separated types of this card
    public var typeLine: String
    /// A URI where you can retrieve a full object describing this card on Scryfall’s API
    public var uri: String

    public init(
      id: UUID, component: RelatedCard.Component, name: String, typeLine: String, uri: String
    ) {
      self.id = id
      self.component = component
      self.name = name
      self.typeLine = typeLine
      self.uri = uri
    }
  }
}
