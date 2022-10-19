//
//  Card+Preview.swift
//  

import Foundation

extension Card {
    /// Metadata about a Magic card's preview
    public struct Preview: Codable, Hashable {
        public var source: String
        public var sourceUri: String
        public var previewedAt: String

        public init(source: String, sourceUri: String, previewedAt: String) {
            self.source = source
            self.sourceUri = sourceUri
            self.previewedAt = previewedAt
        }
    }
}
