//
//  File.swift
//  
//
//  Created by Jacob Hearst on 7/5/22.
//

import Foundation

extension Card {
    /** Get the legality of a card in a given format
     - Parameter format: The format to get legality for
     */
    public func getLegality(for format: Format) -> Legality {
        switch format {
        case .brawl:
            return legalities.brawl ?? .notLegal
        case .standard:
            return legalities.standard ?? .notLegal
        case .historic:
            return legalities.historic ?? .notLegal
        case .pioneer:
            return legalities.pioneer ?? .notLegal
        case .modern:
            return legalities.modern ?? .notLegal
        case .legacy:
            return legalities.legacy ?? .notLegal
        case .pauper:
            return legalities.pauper ?? .notLegal
        case .vintage:
            return legalities.vintage ?? .notLegal
        case .penny:
            return legalities.penny ?? .notLegal
        case .commander:
            return legalities.commander ?? .notLegal
        }
    }
}
