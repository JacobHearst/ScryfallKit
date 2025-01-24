//
//  SmokeTests.swift
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
    // Skip double sided because there aren't any double_sided or battle cards being returned by Scryfall
    for layout in Card.Layout.allCases where ![.doubleSided, .unknown, .battle].contains(layout) {
      let cards = try await client.searchCards(query: "layout:\(layout.rawValue)")
      checkForUnknowns(in: cards.data)
    }
  }

  func testTransformers() async throws {
    _ = try await client.getCardByName(fuzzy: "optimus prime hero")
  }

  func testSearchCardsWithFilters() async throws {
    let filters: [CardFieldFilter] = [.cmc("3", .greaterThan), .colorIdentity("WU")]
    _ = try await client.searchCards(filters: filters)
  }

  func testSearchCards() async throws {
    _ = try await client.searchCards(query: "Sigarda")
  }

  func testSearchCardsMultiplePages() async throws {
    let query = "a"  // Some broad query that will return multiple pages
    let firstPage = try await client.searchCards(query: query)
    let secondPage = try await client.searchCards(query: query, page: 2)

    XCTAssertNotEqual(firstPage.data[0].name, secondPage.data[0].name)
  }

  func testGetCardByExactName() async throws {
    _ = try await client.getCardByName(exact: "Narset, Enlightened Master")
  }

  func testGetCardByFuzzyName() async throws {
    _ = try await client.getCardByName(fuzzy: "Narset, Master")
  }

  func testGetCardNameAutocomplete() async throws {
    let results = try await client.getCardNameAutocomplete(query: "Nars")
    XCTAssertFalse(results.data.isEmpty)
  }

  func testGetRandomCard() async throws {
    _ = try await client.getRandomCard()
  }

  func testGetCardById() async throws {
    // Flumph
    let identifier = Card.Identifier.scryfallID(id: "cdc86e78-8911-4a0d-ba3a-7802f8d991ef")
    _ = try await client.getCard(identifier: identifier)
  }

  func testGetCatalog() async throws {
    _ = try await client.getCatalog(catalogType: .cardNames)
  }

  func testGetSets() async throws {
    _ = try await client.getSets()
  }

  func testGetSetByCode() async throws {
    let identifier = MTGSet.Identifier.code(code: "afr")
    _ = try await client.getSet(identifier: identifier)
  }

  func testGetSet() async throws {
    // Ultimate Masters
    let identifier = MTGSet.Identifier.scryfallID(id: "2ec77b94-6d47-4891-a480-5d0b4e5c9372")
    _ = try await client.getSet(identifier: identifier)
  }

  func testGetRulings() async throws {
    let identifier = Card.Ruling.Identifier.scryfallID(id: "cdc86e78-8911-4a0d-ba3a-7802f8d991ef")
    _ = try await client.getRulings(identifier)
  }

  func testGetSymbology() async throws {
    _ = try await client.getSymbology()
  }

  func testParseManaCost() async throws {
    _ = try await client.parseManaCost("{X}{W}{U}{R}")
  }

  func testSearchWithFieldFilters() async throws {
    let filters: [CardFieldFilter] = [
      CardFieldFilter.type("forest"),
      CardFieldFilter.type("creature"),
    ]
    let cards = try await client.searchCards(filters: filters)

    XCTAssertEqual(cards.totalCards, 1)
  }

  func testSearchWithFieldFiltersWithComparison() async throws {
    let filters: [CardFieldFilter] = [
      CardFieldFilter.cmc("0", .lessThanOrEqual),
      CardFieldFilter.type("Creature"),
      CardFieldFilter.colors("0", .equal),
    ]

    let cards = try await client.searchCards(filters: filters)
    XCTAssert(cards.totalCards ?? 0 > 1)
  }

  func testSearchWithCompoundFieldFilters() async throws {
    let filters: [CardFieldFilter] = [
      CardFieldFilter.type("forest"),
      CardFieldFilter.type("creature"),
    ]

    let compoundFilter = CardFieldFilter.compoundOr(filters)

    let cards = try await client.searchCards(filters: [compoundFilter])
    XCTAssert(cards.totalCards ?? 0 > 1)
  }

  func testGetCardCollection() async throws {
    let identifiers: [Card.CollectionIdentifier] = [
      .scryfallID(id: "683a5707-cddb-494d-9b41-51b4584ded69"),
      .name("Ancient Tomb"),
      .collectorNoAndSet(collectorNo: "150", set: "mrd"),
    ]

    _ = try await client.getCardCollection(identifiers: identifiers)
  }

  func testAllNewCards() async throws {
    // Get sets that released in the past 30 days
    let sets = try await client.getSets().data.filter { mtgSet in
      guard let date = mtgSet.date else {
        print("Couldn't get release date for set: \(mtgSet.name)")
        return false
      }

      let distanceInSeconds = date.distance(to: Date())
      let distanceInDays = distanceInSeconds / 60 / 60 / 24

      return distanceInDays < 30
    }

    // Filter for cards that are in any of the sets
    let filter = CardFieldFilter.compoundOr(sets.map { .set($0.code) })

    // Search
    var results = try await client.searchCards(filters: [filter], unique: .prints)
    checkForUnknowns(in: results.data)
    var page = 1

    // Go through every page
    while results.hasMore ?? false {
      page += 1
      results = try await client.searchCards(filters: [filter], page: page)
      checkForUnknowns(in: results.data)
      usleep(500000)  // Wait for 0.5 seconds
    }
  }

  private func checkForUnknowns(in cards: [Card]) {
    for card in cards {
      XCTAssertNotEqual(card.layout, .unknown, "Unknown layout on \(card.name)")
      XCTAssertNotEqual(card.setType, .unknown, "Unknown set type on \(card.name)")
      if let frameEffects = card.frameEffects {
        for effect in frameEffects {
          XCTAssertNotEqual(effect, .unknown, "Unknown frame effect on \(card.name) [\(card.set)]")
        }
      }
    }
  }
}
