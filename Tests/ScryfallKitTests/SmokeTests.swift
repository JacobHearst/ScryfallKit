//
//  File.swift
//  
//
//  Created by Jacob Hearst on 8/19/21.
//

import XCTest
@testable import ScryfallKit

@available(iOS 13.0.0, *)
final class SmokeTests: XCTestCase {
    var client: ScryfallClient!

    override func setUp() {
        self.client = ScryfallClient()
    }

    func testLayouts() async throws {
        // Verify that we can handle all layout types
        for layout in Layout.allCases {
            // There aren't any double_sided cards being returned by Scryfall
            guard layout != .doubleSided else { continue }

            let _ = try await client.searchCards(query: "layout:\(layout.rawValue)")
        }
    }

    func testSearchCards() async throws {
        let _ = try await client.searchCards(query: "Sigarda")
    }

    func testSearchCardsMultiplePages() async throws {
        let query = "a" // Some broad query that will return multiple pages
        let firstPage = try await client.searchCards(query: query)
        let secondPage = try await client.searchCards(query: query, page: 2)

        XCTAssertNotEqual(firstPage.data[0].name, secondPage.data[0].name)
    }

    func testGetCardByExactName() async throws {
        let _ = try await client.getCardByName(exact: "Narset, Enlightened Master")
    }

    func testGetCardByFuzzyName() async throws {
        let _ = try await client.getCardByName(fuzzy: "Narset, Master")
    }

    func testGetCardBackFaceByExactName() async throws {
        let card = try await client.getCardByName(fuzzy: "Birgi", backFace: true)
        XCTAssertNotNil(card.cardFaces)
    }

    func testGetCardNameAutocomplete() async throws {
        let results = try await client.getCardNameAutocomplete(query: "Nars")
        XCTAssertFalse(results.isEmpty)
    }

    func testGetRandomCard() async throws {
        let _ = try await client.getRandomCard()
    }

    func testGetCardById() async throws {
        // Flumph
        let identifier = Card.Identifier.scryfallID(id: "cdc86e78-8911-4a0d-ba3a-7802f8d991ef")
        let _ = try await client.getCard(identifier: identifier)
    }

    func testGetCatalog() async throws {
        let _ = try await client.getCatalog(catalogType: .cardNames)
    }

    func testGetSets() async throws {
        let _ = try await client.getSets()
    }

    func testGetSetByCode() async throws {
        let identifier = MTGSet.Identifier.code(code: "afr")
        let _ = try await client.getSet(identifier: identifier)
    }

    func testGetSet() async throws {
        // Ultimate Masters
        let identifier = MTGSet.Identifier.scryfallID(id: "2ec77b94-6d47-4891-a480-5d0b4e5c9372")
        let _ = try await client.getSet(identifier: identifier)
    }

    func testGetRulings() async throws {
        let identifier = Ruling.Identifier.scryfallID(id: "cdc86e78-8911-4a0d-ba3a-7802f8d991ef")
        let _ = try await client.getRulings(identifier)
    }

    func testGetSymbology() async throws {
        let _ = try await client.getSymbology()
    }

    func testParseManaCost() async throws {
        let _ = try await client.parseManaCost("{X}{W}{U}{R}")
    }

    func testSearchWithFieldFilters() async throws {
        let filters: [CardFieldFilter] = [
            CardFieldFilter.type("forest"),
            CardFieldFilter.type("creature")
        ]
        let cards = try await client.searchCards(filters: filters)
        
        XCTAssertEqual(cards.totalCards, 1)
    }

    func testSearchWithFieldFiltersWithComparison() async throws {
        let filters: [CardFieldFilter] = [
            CardFieldFilter.cmc("0", .lessThanOrEqual),
            CardFieldFilter.type("Creature"),
            CardFieldFilter.colors("0", .equal)
        ]

        let cards = try await client.searchCards(filters: filters)
        XCTAssert(cards.totalCards ?? 0 > 1)
    }

    func testSearchWithCompoundFieldFilters() async throws {
        let filters: [CardFieldFilter] = [
            CardFieldFilter.type("forest"),
            CardFieldFilter.type("creature")
        ]

        let compoundFilter = CardFieldFilter.compoundOr(filters)

        let cards = try await client.searchCards(filters: [compoundFilter])
        XCTAssert(cards.totalCards ?? 0 > 1)
    }

    func testGetCardCollection() async throws {
        let identifiers: [Card.CollectionIdentifier] = [
            .scryfallID(id: "683a5707-cddb-494d-9b41-51b4584ded69"),
            .name("Ancient Tomb"),
            .collectorNoAndSet(collectorNo: "150", set: "mrd")
        ]

        let _ = try await client.getCardCollection(identifiers: identifiers)
    }
}
