//
//  File.swift
//  
//
//  Created by Jacob Hearst on 7/15/22.
//

import Foundation

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
