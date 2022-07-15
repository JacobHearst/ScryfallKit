//
//  RelatedCard.swift
//  
//
//  Created by Jacob Hearst on 7/15/22.
//

import Foundation

public struct RelatedCard: Codable, Hashable {
    public enum Component: String, Codable, CaseIterable, Hashable {
        case token
        case meldPart = "meld_part"
        case meldResult = "meld_result"
        case comboPiece = "combo_piece"
    }

    public var id: UUID
    public var component: Component
    public var name: String
    public var typeLine: String
    public var uri: String
    
    public init(id: UUID, component: RelatedCard.Component, name: String, typeLine: String, uri: String) {
        self.id = id
        self.component = component
        self.name = name
        self.typeLine = typeLine
        self.uri = uri
    }
}
