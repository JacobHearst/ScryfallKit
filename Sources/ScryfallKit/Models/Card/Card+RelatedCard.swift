//
//  Card+RelatedCard.swift
//

import Foundation

extension Card {
  /// A Magic card that's related to another Magic card
  ///
  /// - Note: In the documentation of this struct, "this card" will refer to the `RelatedCard` object while "the original card" will refer to the `Card` object that contains this object
  public struct RelatedCard: Codable, Identifiable, Hashable, Sendable {
    /// The type of relationship
    public struct Component: RawRepresentable, Codable, CaseIterable, Sendable, Equatable, Hashable
    {
      public static let token = Component(rawValue: "token")
      public static let meldPart = Component(rawValue: "meld_part")
      public static let meldResult = Component(rawValue: "meld_result")
      public static let comboPiece = Component(rawValue: "combo_piece")

      public static let allCases: [Component] = [
        .token,
        .meldPart,
        .meldResult,
        .comboPiece,
      ]

      public let rawValue: String

      public init(rawValue: String) {
        self.rawValue = rawValue
      }
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
