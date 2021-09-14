//
//  File.swift
//  
//
//  Created by Jacob Hearst on 8/19/21.
//

import XCTest
@testable import ScryfallKit

final class SmokeTests: XCTestCase {
    var client: ScryfallClient!

    override func setUp() {
        self.client = ScryfallClient()
    }

    func testLayouts() {
        // Verify that we can handle all layout types
        for layout in Layout.allCases {
            // There aren't any double_sided cards being returned by Scryfall
            guard layout != .doubleSided else { continue }

            let exp = expectation(description: "\(#function)")
            client.searchCards(query: "layout:\(layout.rawValue)") { result in
                switch result {
                case .failure(let error):
                    XCTFail("Received error: \(error)")
                default:
                    break
                }
                exp.fulfill()
            }

            waitForExpectations(timeout: 3)
        }
    }

    func testSearchCards() {
        let exp = expectation(description: "\(#function)")
        client.searchCards(query: "Sigarda") { result in
            switch result {
            case .failure(let error):
                XCTFail("Received error: \(error)")
            default:
                break
            }
            exp.fulfill()
        }

        waitForExpectations(timeout: 3)
    }

    func testSearchCardsMultiplePages() {
        let exp1 = expectation(description: "\(#function)")
        let query = "a" // Some broad query that will return multiple pages
        client.searchCards(query: query) { firstPageResult in
            switch firstPageResult {
            case .failure(let error):
                XCTFail("Received error on first page: \(error)")
            case .success(let firstPage):
                self.client.searchCards(query: query, page: 2) { secondPageResult in
                    switch secondPageResult {
                    case .failure(let error):
                        XCTFail("Received error on second page: \(error)")
                    case .success(let secondPage):
                        XCTAssertNotEqual(firstPage.data[0].name, secondPage.data[0].name)
                    }
                    exp1.fulfill()
                }
            }
        }

        waitForExpectations(timeout: 6)
    }

    func testGetCardByExactName() {
        let exp = expectation(description: "\(#function)")
        client.getCardByName(exact: "Narset, Enlightened Master") { result in
            switch result {
            case .failure(let error):
                XCTFail("Received error: \(error)")
            default:
                break
            }
            exp.fulfill()
        }

        waitForExpectations(timeout: 3)
    }

    func testGetCardByFuzzyName() {
        let exp = expectation(description: "\(#function)")
        client.getCardByName(fuzzy: "Narset, Master") { result in
            switch result {
            case .failure(let error):
                XCTFail("Received error: \(error)")
            default:
                break
            }
            exp.fulfill()
        }

        waitForExpectations(timeout: 3)
    }

    func testGetCardBackFaceByExactName() {
        let exp = expectation(description: "\(#function)")
        client.getCardByName(fuzzy: "Birgi", backFace: true) { result in
            switch result {
            case .failure(let error):
                XCTFail("Received error: \(error)")
            case .success(let card):
                XCTAssertNotNil(card.cardFaces)
            }
            exp.fulfill()
        }

        waitForExpectations(timeout: 3)
    }

    func testGetCardNameAutocomplete() {
        let exp = expectation(description: "\(#function)")
        client.getCardNameAutocomplete(query: "Nars") { result in
            switch result {
            case .failure(let error):
                XCTFail("Received error: \(error)")
            default:
                break
            }
            exp.fulfill()
        }

        waitForExpectations(timeout: 3)
    }

    func testGetRandomCard() {
        let exp = expectation(description: "\(#function)")
        client.getRandomCard() { result in
            switch result {
            case .failure(let error):
                XCTFail("Received error: \(error)")
            default:
                break
            }
            exp.fulfill()
        }

        waitForExpectations(timeout: 3)
    }

    func testGetCardById() {
        let exp = expectation(description: "\(#function)")

        // Flumph
        let identifier = Card.Identifier.scryfallID(id: "cdc86e78-8911-4a0d-ba3a-7802f8d991ef")
        client.getCard(identifier: identifier) { result in
            switch result {
            case .failure(let error):
                XCTFail("Received error: \(error)")
            default:
                break
            }
            exp.fulfill()
        }

        waitForExpectations(timeout: 3)
    }

    func testGetCatalog() {
        let exp = expectation(description: "\(#function)")
        client.getCatalog(catalogType: .cardNames) { result in
            switch result {
            case .failure(let error):
                XCTFail("Received error: \(error)")
            default:
                break
            }
            exp.fulfill()
        }

        waitForExpectations(timeout: 3)
    }

    func testGetSets() {
        let exp = expectation(description: "\(#function)")
        client.getSets() { result in
            switch result {
            case .failure(let error):
                XCTFail("Received error: \(error)")
            default:
                break
            }
            exp.fulfill()
        }

        waitForExpectations(timeout: 3)
    }

    func testGetSetByCode() {
        let exp = expectation(description: "\(#function)")
        let identifier = Set.Identifier.code(code: "afr")
        client.getSet(identifier: identifier) { result in
            switch result {
            case .failure(let error):
                XCTFail("Received error: \(error)")
            default:
                break
            }
            exp.fulfill()
        }

        waitForExpectations(timeout: 3)
    }

    func testGetSet() {
        let exp = expectation(description: "\(#function)")

        // Ultimate Masters
        let identifier = Set.Identifier.scryfallID(id: "2ec77b94-6d47-4891-a480-5d0b4e5c9372")
        client.getSet(identifier: identifier) { result in
            switch result {
            case .failure(let error):
                XCTFail("Received error: \(error)")
            default:
                break
            }
            exp.fulfill()
        }

        waitForExpectations(timeout: 3)
    }

    func testGetRulings() {
        let exp = expectation(description: "\(#function)")

        let identifier = Ruling.Identifier.scryfallID(id: "cdc86e78-8911-4a0d-ba3a-7802f8d991ef")
        client.getRulings(identifier) { result in
            switch result {
            case .failure(let error):
                XCTFail("Received error: \(error)")
            default:
                break
            }
            exp.fulfill()
        }

        waitForExpectations(timeout: 3)
    }

    func testGetSymbology() {
        let exp = expectation(description: "\(#function)")
        client.getSymbology() { result in
            switch result {
            case .failure(let error):
                XCTFail("Received error: \(error)")
            default:
                break
            }
            exp.fulfill()
        }

        waitForExpectations(timeout: 3)
    }

    func testParseManaCost() {
        let exp = expectation(description: "\(#function)")
        client.parseManaCost("{X}{W}{U}{R}") { result in
            switch result {
            case .failure(let error):
                XCTFail("Received error: \(error)")
            default:
                break
            }
            exp.fulfill()
        }

        waitForExpectations(timeout: 3)
    }
}
