//
//  ScryfallError.swift
//  

import Foundation

public struct ScryfallError: Codable, CustomStringConvertible {
    public var status: Int
    public var code: String
    public var details: String
    public var type: String?
    public var warnings: [String]?

    public init(status: Int, code: String, details: String, type: String? = nil, warnings: [String]? = nil) {
        self.status = status
        self.code = code
        self.details = details
        self.type = type
        self.warnings = warnings
    }

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
