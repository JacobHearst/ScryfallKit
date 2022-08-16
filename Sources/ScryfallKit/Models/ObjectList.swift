//
//  File.swift
//  
//
//  Created by Jacob Hearst on 6/9/21.
//

import Foundation

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
