//
//  File.swift
//  
//
//  Created by Jacob Hearst on 6/9/21.
//

import Foundation

public struct List<T: Codable>: Codable {
    public var data: [T]
    public var hasMore: Bool?
    public var object: String
    public var nextPage: String?
    public var totalCards: Int?
    public var warnings: [String]?
}
