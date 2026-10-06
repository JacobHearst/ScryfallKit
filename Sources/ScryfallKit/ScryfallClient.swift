//
//  ScryfallClient.swift
//

import Foundation
import OSLog

/// A client for interacting with the Scryfall API
public final class ScryfallClient: Sendable {
    let networkService: NetworkServiceProtocol

    /// Initialize an instance of the ScryfallClient
    /// - Parameters:
    ///   - userAgent: The value for the HTTP User-Agent header; required by Scryfall's API usage terms
    ///   - logger: The logger to use. Pass nil to disable logging
    ///   - rateLimiter: An optional ``RateLimiter`` to throttle outgoing requests. Pass nil (the default) to
    ///     disable throttling.
    public init(userAgent: String? = nil, logger: Logger? = nil, rateLimiter: RateLimiter? = nil) {
        self.networkService = NetworkService(
            userAgent: userAgent,
            logger: logger,
            rateLimiter: rateLimiter
        )
    }

    /// Perform a search using an array of ``CardFieldFilter`` objects.
    ///
    /// Performs a Scryfall search using the `/cards/search` endpoint. This method is simply a convenience wrapper around ``searchCards(query:unique:order:sortDirection:includeExtras:includeMultilingual:includeVariations:page:)``
    ///
    /// Full reference at: https://scryfall.com/docs/api/cards/search.
    ///
    /// - Parameters:
    ///   - filters: Only include cards matching these filters
    ///   - unique: The strategy for omitting similar cards. See ``UniqueMode``
    ///   - order: The method to sort returned cards. See ``SortMode``
    ///   - sortDirection: The direction to sort cards. See ``SortDirection``
    ///   - includeExtras: If true, extra cards (tokens, planes, etc) will be included. Equivalent to adding include:extras to the fulltext search. Defaults to `false`
    ///   - includeMultilingual: If true, cards in every language supported by Scryfall will be included. Defaults to `false`.
    ///   - includeVariations: If true, rare care variants will be included, like the Hairy Runesword. Defaults to `false`.
    ///   - page: The page number to return. Defaults to `1`
    public func searchCards(
        filters: [CardFieldFilter],
        unique: UniqueMode? = nil,
        order: SortMode? = nil,
        sortDirection: SortDirection? = nil,
        includeExtras: Bool? = nil,
        includeMultilingual: Bool? = nil,
        includeVariations: Bool? = nil,
        page: Int? = nil
    ) async throws -> ObjectList<Card> {
        let query = filters.map { $0.filterString }.joined(separator: " ")
        return try await searchCards(
            query: query,
            unique: unique,
            order: order,
            sortDirection: sortDirection,
            includeExtras: includeExtras,
            includeMultilingual: includeMultilingual,
            includeVariations: includeVariations,
            page: page
        )
    }

    /// Perform a search using a string conforming to Scryfall query syntax.
    ///
    /// Full reference at: https://scryfall.com/docs/api/cards/search.
    ///
    /// - Parameters:
    ///   - filters: Only include cards matching these filters
    ///   - unique: The strategy for omitting similar cards. See ``UniqueMode``
    ///   - order: The method to sort returned cards. See ``SortMode``
    ///   - sortDirection: The direction to sort cards. See ``SortDirection``
    ///   - includeExtras: If true, extra cards (tokens, planes, etc) will be included. Equivalent to adding include:extras to the fulltext search. Defaults to `false`
    ///   - includeMultilingual: If true, cards in every language supported by Scryfall will be included. Defaults to `false`.
    ///   - includeVariations: If true, rare care variants will be included, like the Hairy Runesword. Defaults to `false`.
    ///   - page: The page number to return. Defaults to `1`
    public func searchCards(
        query: String,
        unique: UniqueMode? = nil,
        order: SortMode? = nil,
        sortDirection: SortDirection? = nil,
        includeExtras: Bool? = nil,
        includeMultilingual: Bool? = nil,
        includeVariations: Bool? = nil,
        page: Int? = nil
    ) async throws -> ObjectList<Card> {
        let request = SearchCards(
            query: query,
            unique: unique,
            order: order,
            dir: sortDirection,
            includeExtras: includeExtras,
            includeMultilingual: includeMultilingual,
            includeVariations: includeVariations,
            page: page
        )

        return try await networkService.request(request, as: ObjectList<Card>.self)
    }

    /// Get a card with the exact name supplied
    ///
    /// Full reference at: https://scryfall.com/docs/api/cards/named
    ///
    /// - Parameters:
    ///   - exact: The exact card name to search for, case insenstive.
    ///   - set: A set code to limit the search to one set.
    public func getCardByName(exact: String, set: String? = nil) async throws -> Card {
        let request = GetCardNamed(exact: exact, set: set)
        return try await networkService.request(request, as: Card.self)
    }

    /// Get a card with a name close to what was entered
    ///
    /// Full reference at: https://scryfall.com/docs/api/cards/named
    ///
    /// - Parameters:
    ///   - fuzzy: The exact card name to search for, case insenstive.
    ///   - set: A set code to limit the search to one set.
    public func getCardByName(fuzzy: String, set: String? = nil) async throws -> Card {
        let request = GetCardNamed(fuzzy: fuzzy, set: set)
        return try await networkService.request(request, as: Card.self)
    }

    /// Retrieve up to 20 card name autocomplete suggestions for a given string.
    ///
    /// Full reference at: https://scryfall.com/docs/api/cards/autocomplete
    ///
    /// - Parameters:
    ///   - query: The string to autocomplete
    ///   - includeExtras: If true, extra cards (tokens, planes, vanguards, etc) will be included. Defaults to false.
    /// - Returns: A ``Catalog`` of card names
    public func getCardNameAutocomplete(query: String, includeExtras: Bool? = nil) async throws
        -> Catalog
    {
        let request = GetCardAutocomplete(query: query, includeExtras: includeExtras)
        return try await networkService.request(request, as: Catalog.self)
    }

    /// Get a single random card
    ///
    /// [Scryfall documentation](https://scryfall.com/docs/api/cards/random)
    ///
    /// - Parameters:
    ///   - query: An optional fulltext search query to filter the pool of random cards.
    public func getRandomCard(query: String? = nil) async throws -> Card {
        let request = GetRandomCard(query: query)
        return try await networkService.request(request, as: Card.self)
    }

    /// Get a single card using a Card identifier.
    ///
    /// [Scryfall documentation](https://scryfall.com/docs/api/cards)
    ///
    /// See ``Card/Identifier`` for more information on identifiers
    ///
    /// - Parameters:
    ///   - identifier: The identifier for the desired card
    public func getCard(identifier: Card.Identifier) async throws -> Card {
        let request = GetCard(identifier: identifier)
        return try await networkService.request(request, as: Card.self)
    }

    /// Bulk request up to 75 cards at a time.
    ///
    /// [Scryfall documentation](https://scryfall.com/docs/api/cards/collection)
    ///
    /// - Parameters:
    ///   - identifiers: The array of identifiers
    public func getCardCollection(identifiers: [Card.CollectionIdentifier]) async throws
        -> ObjectList<Card>
    {
        let request = GetCardCollection(identifiers: identifiers)
        return try await networkService.request(request, as: ObjectList<Card>.self)
    }

    /// Get a catalog of Magic datapoints (keyword abilities, artist names, spell types, etc)
    ///
    /// [Scryfall documentation](https://scryfall.com/docs/api/catalogs)
    ///
    /// - Parameters:
    ///   - catalogType: The type of catalog to retrieve
    public func getCatalog(catalogType: Catalog.`Type`) async throws -> Catalog {
        let request = GetCatalog(catalogType: catalogType)
        return try await networkService.request(request, as: Catalog.self)
    }

    /// Get all MTG sets
    ///
    /// [Scryfall documentation](https://scryfall.com/docs/api/sets/all)
    ///
    public func getSets() async throws -> ObjectList<MTGSet> {
        return try await networkService.request(GetSets(), as: ObjectList<MTGSet>.self)
    }

    /// Get a specific MTG set
    ///
    /// [Scryfall documentation](https://scryfall.com/docs/api/sets)
    ///
    /// See ``MTGSet/Identifier`` for more information on set identifiers
    ///
    /// - Parameters:
    ///   - identifier: The set's identifier
    public func getSet(identifier: MTGSet.Identifier) async throws -> MTGSet {
        let request = GetSet(identifier: identifier)
        return try await networkService.request(request, as: MTGSet.self)
    }

    /// Get the rulings for a specific card.
    ///
    /// [Scryfall documentation](https://scryfall.com/docs/api/rulings)
    ///
    /// See ``Card/Ruling/Identifier`` for more information on ruling identifiers
    ///
    /// - Parameters:
    ///   - identifier: An identifier for the ruling you wish to retrieve
    public func getRulings(_ identifier: Card.Ruling.Identifier) async throws -> ObjectList<
        Card.Ruling
    > {
        let request = GetRulings(identifier: identifier)
        return try await networkService.request(request, as: ObjectList<Card.Ruling>.self)
    }

    /// Get all MTG symbology
    ///
    /// [Scryfall documentation](https://scryfall.com/docs/api/card-symbols/all)
    ///
    public func getSymbology() async throws -> ObjectList<Card.Symbol> {
        return try await networkService.request(GetSymbology(), as: ObjectList<Card.Symbol>.self)
    }

    /// Parse a string representing a mana cost and retun Scryfall's interpretation
    ///
    /// [Scryfall documentation](https://scryfall.com/docs/api/card-symbols/parse-mana)
    ///
    /// - Parameters:
    ///   - cost: The string to parse
    public func parseManaCost(_ cost: String) async throws -> Card.ManaCost {
        let request = ParseManaCost(cost: cost)
        return try await networkService.request(request, as: Card.ManaCost.self)
    }
}
