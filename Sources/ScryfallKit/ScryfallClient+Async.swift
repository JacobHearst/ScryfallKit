//
//  ScryfallClient+Async.swift
//  
//
//  Created by Jacob Hearst on 7/1/22.
//

import Foundation

@available(macOS 10.15.0, *)
extension ScryfallClient {
    public func searchCards(filters: [CardFieldFilter],
                            unique: UniqueMode? = nil,
                            order: SortMode? = nil,
                            sortDirection: SortDirection? = nil,
                            include_extras: Bool? = nil,
                            include_multilingual: Bool? = nil,
                            include_variations: Bool? = nil,
                            page: Int? = nil) async throws -> List<Card> {
        let query = filters.map { $0.filterString }.joined(separator: " ")

        let request = SearchCards(
            query: query,
            unique: unique,
            order: order,
            dir: sortDirection,
            include_extras: include_extras,
            include_multilingual: include_multilingual,
            include_variations: include_variations,
            page: page)

        return try await networkService.request(request, as: List<Card>.self)
    }

    public func searchCards(query: String,
                            unique: UniqueMode? = nil,
                            order: SortMode? = nil,
                            sortDirection: SortDirection? = nil,
                            include_extras: Bool? = nil,
                            include_multilingual: Bool? = nil,
                            include_variations: Bool? = nil,
                            page: Int? = nil) async throws -> List<Card> {
        let request = SearchCards(
            query: query,
            unique: unique,
            order: order,
            dir: sortDirection,
            include_extras: include_extras,
            include_multilingual: include_multilingual,
            include_variations: include_variations,
            page: page)

        return try await networkService.request(request, as: List<Card>.self)
    }

    public func getCardByName(exact: String,
                              set: String? = nil,
                              backFace: Bool = false,
                              version: Card.ImageType? = nil) async throws -> Card {
        let request = GetCardNamed(
            exact: exact,
            set: set,
            backFace: backFace,
            version: version)

        return try await networkService.request(request, as: Card.self)
    }

    public func getCardByName(fuzzy: String,
                              set: String? = nil,
                              backFace: Bool = false,
                              version: Card.ImageType? = nil) async throws -> Card {

        let request = GetCardNamed(
            fuzzy: fuzzy,
            set: set,
            backFace: backFace,
            version: version)

        return try await networkService.request(request, as: Card.self)
    }

    public func getCardNameAutocomplete(query: String, include_extras: Bool? = nil) async throws -> [String] {
        let request = GetCardAutocomplete(query: query, include_extras: include_extras)
        return try await networkService.request(request, as: Catalog.self).data
    }

    public func getRandomCard(query: String? = nil, backFace: Bool = false, version: Card.ImageType? = nil) async throws -> Card {

        let request = GetRandomCard(
            query: query,
            backFace: backFace,
            version: version)

        return try await networkService.request(request, as: Card.self)
    }

    public func getCard(identifier: Card.Identifier, backFace: Bool = false) async throws -> Card {
        let request = GetCard(identifier: identifier, backFace: backFace)

        return try await networkService.request(request, as: Card.self)
    }

    public func getCardCollection(identifiers: [Card.CollectionIdentifier]) async throws -> List<Card> {
        let request = GetCardCollection(identifiers: identifiers)
        return try await networkService.request(request, as: List<Card>.self)
    }

    public func getCatalog(catalogType: Catalog.`Type`) async throws -> Catalog {
        let request = GetCatalog(catalogType: catalogType)
        return try await networkService.request(request, as: Catalog.self)
    }

    public func getSets() async throws -> List<Set> {
        try await networkService.request(GetSets(), as: List<Set>.self)
    }

    public func getSet(identifier: Set.Identifier) async throws -> Set {
        let request = GetSet(identifier: identifier)
        return try await networkService.request(request, as: Set.self)
    }

    public func getRulings(_ identifier: Ruling.Identifier) async throws -> List<Ruling> {
        let request = GetRulings(identifier: identifier)
        return try await networkService.request(request, as: List<Ruling>.self)
    }

    public func getSymbology() async throws -> List<CardSymbol> {
        try await networkService.request(GetSymbology(), as: List<CardSymbol>.self)
    }

    public func parseManaCost(_ cost: String) async throws -> ManaCost {
        let request = ParseManaCost(cost: cost)
        return try await networkService.request(request, as: ManaCost.self)
    }
}
