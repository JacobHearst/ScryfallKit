//
//  ObjectList.swift
//  

import Foundation

/// A sequence of Scryfall objects. May be paginated
///
/// [Scryfall documentation](https://scryfall.com/docs/api/lists)
public struct ObjectList<T: Codable>: Codable {
    public var data: [T]
    public var hasMore: Bool?
    public var object: String
    public var nextPage: String?
    public var totalCards: Int?
    public var warnings: [String]?

    public init(data: [T], hasMore: Bool? = nil, object: String, nextPage: String? = nil, totalCards: Int? = nil, warnings: [String]? = nil) {
        self.data = data
        self.hasMore = hasMore
        self.object = object
        self.nextPage = nextPage
        self.totalCards = totalCards
        self.warnings = warnings
    }
}
