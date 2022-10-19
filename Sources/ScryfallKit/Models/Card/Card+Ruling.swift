//
//  Card+Ruling.swift
//

import Foundation

extension Card {
    /// An object representing a ruling on a specific card
    public struct Ruling: Codable, Identifiable {
        public enum Identifier {
            case scryfallID(id: String)
            case mtgoID(id: Int)
            case multiverseID(id: Int)
            case arenaID(id: Int)
            case collectorNumberSet(collectorNumber: String, set: String)
        }

        public var source: String
        public var publishedAt: String
        public var comment: String
        public var oracleId: String

        /// An id made by concatenating the oracle id and the comment itself
        public var id: String { oracleId + comment }

        public init(source: String, publishedAt: String, comment: String, oracleId: String) {
            self.source = source
            self.publishedAt = publishedAt
            self.comment = comment
            self.oracleId = oracleId
        }
    }
}
