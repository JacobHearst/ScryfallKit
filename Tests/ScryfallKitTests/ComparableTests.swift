//
//  ComparableTests.swift
//

import ScryfallKit
import Testing

struct ComparableTests {
    @Test func colorSort() {
        // Given
        let colors: [Card.Color] = [.B, .C, .W, .U, .G, .R]

        // When
        let result = colors.sorted()

        // Then
        let expected: [Card.Color] = [.W, .U, .B, .R, .G, .C]
        #expect(result == expected)
    }

    @Test func raritySort() {
        // Given
        let rarities: [Card.Rarity] = [.mythic, .common, .rare, .uncommon, .bonus, .special]

        // When
        let result = rarities.sorted()

        // Then
        let expected: [Card.Rarity] = [.bonus, .special, .common, .uncommon, .rare, .mythic]
        #expect(result == expected)
    }
}
