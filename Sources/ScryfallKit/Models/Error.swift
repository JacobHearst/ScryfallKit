//
//  File.swift
//  
//
//  Created by Jacob Hearst on 6/13/21.
//

import Foundation

public struct ScryfallError: Codable, CustomStringConvertible {
    public var status: Int
    public var code: String
    public var details: String
    public var type: String?
    public var warnings: [String]?

    public var description: String {
        return """
        Scryfall Error
        - Status: \(status)
        - Code: \(code)
        - Details: \(details)
        - Type?: \(String(describing: type))
        - Warnings?: \(String(describing: warnings))
        """
    }
}
