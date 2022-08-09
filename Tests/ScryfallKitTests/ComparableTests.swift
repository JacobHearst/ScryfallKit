//
//  ComparableTests.swift
//  
//
//  Created by Jacob Hearst on 8/1/22.
//

import XCTest
@testable import ScryfallKit

class ComparableTests: XCTestCase {
    func testColorSort() {
        // Given
        let colors: [CardColor] = [.B, .C, .W, .U, .G, .R]
        
        // When
        let result = colors.sorted()
        
        // Then
        let expected: [CardColor] = [.W, .U, .B, .R, .G, .C]
        XCTAssertEqual(result, expected)
    }
    
    func testRaritySort() {
        // Given
        let rarities: [Card.Rarity] = [.mythic, .common, .rare, .uncommon, .bonus, .special]
        
        // When
        let result = rarities.sorted()
        
        // Then
        let expected: [Card.Rarity] = [.bonus, .special, .common, .uncommon, .rare, .mythic]
        XCTAssertEqual(result, expected)
    }
}
