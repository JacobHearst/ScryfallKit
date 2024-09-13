//
//  Card+Preview.swift
//

import Foundation

extension Card {
  /// Metadata about a Magic card's preview
  public struct Preview: Codable, Hashable, Sendable {
    /// The name of the source that previewed this card.
    public var source: String
    /// A link to the preview for this card.
    public var sourceUri: String
    /// The date this card was previewed.
    public var previewedAt: String

    public init(source: String, sourceUri: String, previewedAt: String) {
      self.source = source
      self.sourceUri = sourceUri
      self.previewedAt = previewedAt
    }
  }
}
