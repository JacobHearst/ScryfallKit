//
//  SmokeTests.swift
//
import OSLog
import Testing

@testable import ScryfallKit

struct SmokeTests {
    // Swift Testing creates a new suite instance per test and runs tests in parallel, so the limiter
    // must be static to be shared by every test's client. The most restrictive rate limit in
    // Scryfall's docs is 2 requests/second
    static let rateLimiter = RateLimiter(requestsPerSecond: 2)

    let client = ScryfallClient(
        logger: Logger(subsystem: "dev.hearst.ScryfallKitTests", category: "SmokeTests"),
        rateLimiter: SmokeTests.rateLimiter
    )

    @Test func layouts() async throws {
        // Verify that we can handle all layout types
        // Skip double sided because there aren't any double_sided or battle cards being returned by Scryfall
        for layout in Card.Layout.allCases where ![.doubleSided, .battle].contains(layout) {
            let cards = try await client.searchCards(
                query: "layout:\(layout.rawValue.lowercased())"
            )
            checkForUnknowns(in: cards.data)
        }
    }

    @Test func transformers() async throws {
        _ = try await client.getCardByName(fuzzy: "optimus prime hero")
    }

    @Test func searchCardsWithFilters() async throws {
        let filters: [CardFieldFilter] = [.cmc("3", .greaterThan), .colorIdentity("WU")]
        _ = try await client.searchCards(filters: filters)
    }

    @Test func searchCards() async throws { _ = try await client.searchCards(query: "Sigarda") }

    @Test func searchCardsMultiplePages() async throws {
        let query = "a"  // Some broad query that will return multiple pages
        let firstPage = try await client.searchCards(query: query)
        let secondPage = try await client.searchCards(query: query, page: 2)

        #expect(firstPage.data[0].name != secondPage.data[0].name)
    }

    @Test func getCardByExactName() async throws {
        _ = try await client.getCardByName(exact: "Narset, Enlightened Master")
    }

    @Test func getCardByFuzzyName() async throws {
        _ = try await client.getCardByName(fuzzy: "narset enlight mast")
    }

    @Test func getCardNameAutocomplete() async throws {
        let results = try await client.getCardNameAutocomplete(query: "Nars")
        #expect(!results.data.isEmpty)
    }

    @Test func getRandomCard() async throws { _ = try await client.getRandomCard() }

    @Test func getCardById() async throws {
        // Flumph
        let identifier = Card.Identifier.scryfallID(id: "cdc86e78-8911-4a0d-ba3a-7802f8d991ef")
        _ = try await client.getCard(identifier: identifier)
    }

    @Test func getCatalog() async throws {
        _ = try await client.getCatalog(catalogType: .cardNames)
    }

    @Test func getSets() async throws { _ = try await client.getSets() }

    @Test func getSetByCode() async throws {
        let identifier = MTGSet.Identifier.code(code: "afr")
        _ = try await client.getSet(identifier: identifier)
    }

    @Test func getSet() async throws {
        // Ultimate Masters
        let identifier = MTGSet.Identifier.scryfallID(id: "2ec77b94-6d47-4891-a480-5d0b4e5c9372")
        _ = try await client.getSet(identifier: identifier)
    }

    @Test func getRulings() async throws {
        let identifier = Card.Ruling.Identifier.scryfallID(
            id: "cdc86e78-8911-4a0d-ba3a-7802f8d991ef"
        )
        _ = try await client.getRulings(identifier)
    }

    @Test func getSymbology() async throws { _ = try await client.getSymbology() }

    @Test func parseManaCost() async throws { _ = try await client.parseManaCost("{X}{W}{U}{R}") }

    @Test func searchWithFieldFilters() async throws {
        let filters: [CardFieldFilter] = [
            CardFieldFilter.type("forest"), CardFieldFilter.type("creature"),
        ]
        let cards = try await client.searchCards(filters: filters)

        #expect(cards.totalCards == 1)
    }

    @Test func searchWithFieldFiltersWithComparison() async throws {
        let filters: [CardFieldFilter] = [
            CardFieldFilter.cmc("0", .lessThanOrEqual), CardFieldFilter.type("Creature"),
            CardFieldFilter.colors("0", .equal),
        ]

        let cards = try await client.searchCards(filters: filters)
        #expect((cards.totalCards ?? 0) > 1)
    }

    @Test func searchWithCompoundFieldFilters() async throws {
        let filters: [CardFieldFilter] = [
            CardFieldFilter.type("forest"), CardFieldFilter.type("creature"),
        ]

        let compoundFilter = CardFieldFilter.compoundOr(filters)

        let cards = try await client.searchCards(filters: [compoundFilter])
        #expect((cards.totalCards ?? 0) > 1)
    }

    @Test func getCardCollection() async throws {
        let identifiers: [Card.CollectionIdentifier] = [
            .scryfallID(id: "683a5707-cddb-494d-9b41-51b4584ded69"), .name("Ancient Tomb"),
            .collectorNoAndSet(collectorNo: "150", set: "mrd"),
        ]

        _ = try await client.getCardCollection(identifiers: identifiers)
    }

    @Test func allNewCards() async throws {
        // Get sets that released in the past 30 days
        let sets = try await client.getSets().data
            .filter { mtgSet in
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
            try await Task.sleep(for: .seconds(1))
            page += 1
            results = try await client.searchCards(filters: [filter], page: page)
            checkForUnknowns(in: results.data)
        }
    }

    private func checkForUnknowns(in cards: [Card]) {
        // Note that `producedMana` is deliberately not checked here: an unknown ProducedColor is
        // expected rather than a gap in ScryfallKit, because Scryfall reports values that aren't
        // colors at all (Unfinity's Sole Performer produces "T").
        for card in cards {
            if let frameEffects = card.frameEffects {
                for effect in frameEffects {
                    if !Card.FrameEffect.allCases.contains(effect) {
                        Issue.record("Unknown frame effect: \(effect.rawValue)")
                    }
                }
            }

            if !Card.Layout.allCases.contains(card.layout) {
                Issue.record("Unknown layout: \(card.layout.rawValue) on \(card.name)")
            }

            for face in card.cardFaces ?? [] {
                if let layout = face.layout, !Card.Layout.allCases.contains(layout) {
                    Issue.record("Unknown face layout: \(layout.rawValue) on \(card.name)")
                }
            }

            if !MTGSet.Kind.allCases.contains(card.setType) {
                Issue.record("Unknown set type: \(card.setType.rawValue) on \(card.name)")
            }
        }
    }
}
