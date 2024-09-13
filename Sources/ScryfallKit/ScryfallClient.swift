//
//  ScryfallClient.swift
//

import Foundation

/// A client for interacting with the Scryfall API
public final class ScryfallClient: Sendable {
  private let networkLogLevel: NetworkLogLevel
  let networkService: NetworkServiceProtocol

  /// Initialize an instance of the ScryfallClient
  /// - Parameter networkLogLevel: The desired logging level. See ``NetworkLogLevel``
  public init(networkLogLevel: NetworkLogLevel = .minimal) {
    self.networkLogLevel = networkLogLevel
    self.networkService = NetworkService(logLevel: networkLogLevel)
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
  ///   - completion: A function/block to be called when the search is complete
  public func searchCards(
    filters: [CardFieldFilter],
    unique: UniqueMode? = nil,
    order: SortMode? = nil,
    sortDirection: SortDirection? = nil,
    includeExtras: Bool? = nil,
    includeMultilingual: Bool? = nil,
    includeVariations: Bool? = nil,
    page: Int? = nil,
    completion: @Sendable @escaping (Result<ObjectList<Card>, Error>) -> Void
  ) {
    let query = filters.map { $0.filterString }.joined(separator: " ")
    searchCards(
      query: query,
      unique: unique,
      order: order,
      sortDirection: sortDirection,
      includeExtras: includeExtras,
      includeMultilingual: includeMultilingual,
      includeVariations: includeVariations,
      page: page,
      completion: completion)
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
  ///   - completion: A function/block to be called when the search is complete
  public func searchCards(
    query: String,
    unique: UniqueMode? = nil,
    order: SortMode? = nil,
    sortDirection: SortDirection? = nil,
    includeExtras: Bool? = nil,
    includeMultilingual: Bool? = nil,
    includeVariations: Bool? = nil,
    page: Int? = nil,
    completion: @Sendable @escaping (Result<ObjectList<Card>, Error>) -> Void
  ) {

    let request = SearchCards(
      query: query,
      unique: unique,
      order: order,
      dir: sortDirection,
      includeExtras: includeExtras,
      includeMultilingual: includeMultilingual,
      includeVariations: includeVariations,
      page: page)

    networkService.request(request, as: ObjectList<Card>.self, completion: completion)
  }

  /// Get a card with the exact name supplied
  ///
  /// Full reference at: https://scryfall.com/docs/api/cards/named
  ///
  /// - Parameters:
  ///   - exact: The exact card name to search for, case insenstive.
  ///   - set: A set code to limit the search to one set.
  ///   - completion: A function/block to be called when the search is complete
  public func getCardByName(
    exact: String, set: String? = nil, completion: @Sendable @escaping (Result<Card, Error>) -> Void
  ) {
    let request = GetCardNamed(exact: exact, set: set)
    networkService.request(request, as: Card.self, completion: completion)
  }

  /// Get a card with a name close to what was entered
  ///
  /// Full reference at: https://scryfall.com/docs/api/cards/named
  ///
  /// - Parameters:
  ///   - fuzzy: The exact card name to search for, case insenstive.
  ///   - set: A set code to limit the search to one set.
  ///   - completion: A function/block to be called when the search is complete
  public func getCardByName(
    fuzzy: String, set: String? = nil, completion: @Sendable @escaping (Result<Card, Error>) -> Void
  ) {
    let request = GetCardNamed(fuzzy: fuzzy, set: set)
    networkService.request(request, as: Card.self, completion: completion)
  }

  /// Retrieve up to 20 card name autocomplete suggestions for a given string.
  ///
  /// Full reference at: https://scryfall.com/docs/api/cards/autocomplete
  ///
  /// - Parameters:
  ///   - query: The string to autocomplete
  ///   - includeExtras: If true, extra cards (tokens, planes, vanguards, etc) will be included. Defaults to false.
  ///   - completion: A function/block to be called when the search is complete
  /// - Returns: A ``Catalog`` of card names or an error
  public func getCardNameAutocomplete(
    query: String, includeExtras: Bool? = nil,
    completion: @Sendable @escaping (Result<Catalog, Error>) -> Void
  ) {
    let request = GetCardAutocomplete(query: query, includeExtras: includeExtras)
    networkService.request(request, as: Catalog.self, completion: completion)
  }

  /// Get a single random card
  ///
  /// [Scryfall documentation](https://scryfall.com/docs/api/cards/random)
  ///
  /// - Parameters:
  ///   - query: An optional fulltext search query to filter the pool of random cards.
  ///   - completion: A function/block to call when the request is complete
  public func getRandomCard(
    query: String? = nil, completion: @Sendable @escaping (Result<Card, Error>) -> Void
  ) {
    let request = GetRandomCard(query: query)
    networkService.request(request, as: Card.self, completion: completion)
  }

  /// Get a single card using a Card identifier.
  ///
  /// [Scryfall documentation](https://scryfall.com/docs/api/cards)
  ///
  /// See ``Card/Identifier`` for more information on identifiers
  ///
  /// - Parameters:
  ///   - identifier: The identifier for the desired card
  ///   - completion: A function/block to call when the request is complete
  public func getCard(
    identifier: Card.Identifier, completion: @Sendable @escaping (Result<Card, Error>) -> Void
  ) {
    let request = GetCard(identifier: identifier)
    networkService.request(request, as: Card.self, completion: completion)
  }

  /// Bulk request up to 75 cards at a time.
  ///
  /// [Scryfall documentation](https://scryfall.com/docs/api/cards/collection)
  ///
  /// - Parameters:
  ///   - identifiers: The array of identifiers
  ///   - completion: A function/block to call when the request is complete
  public func getCardCollection(
    identifiers: [Card.CollectionIdentifier],
    completion: @Sendable @escaping (Result<ObjectList<Card>, Error>) -> Void
  ) {
    let request = GetCardCollection(identifiers: identifiers)
    networkService.request(request, as: ObjectList<Card>.self, completion: completion)
  }

  /// Get a catalog of Magic datapoints (keyword abilities, artist names, spell types, etc)
  ///
  /// [Scryfall documentation](https://scryfall.com/docs/api/catalogs)
  ///
  /// - Parameters:
  ///   - catalogType: The type of catalog to retrieve
  ///   - completion: A function/block to call when the request is complete
  public func getCatalog(
    catalogType: Catalog.`Type`, completion: @Sendable @escaping (Result<Catalog, Error>) -> Void
  ) {
    let request = GetCatalog(catalogType: catalogType)
    networkService.request(request, as: Catalog.self, completion: completion)
  }

  /// Get all MTG sets
  ///
  /// [Scryfall documentation](https://scryfall.com/docs/api/sets/all)
  ///
  /// - Parameter completion: A function/block to call when the request is complete
  public func getSets(completion: @Sendable @escaping (Result<ObjectList<MTGSet>, Error>) -> Void) {
    networkService.request(GetSets(), as: ObjectList<MTGSet>.self, completion: completion)
  }

  /// Get a specific MTG set
  ///
  /// [Scryfall documentation](https://scryfall.com/docs/api/sets)
  ///
  /// See ``MTGSet/Identifier`` for more information on set identifiers
  ///
  /// - Parameters:
  ///   - identifier: The set's identifier
  ///   - completion: A function/block to call when the request is complete
  public func getSet(
    identifier: MTGSet.Identifier, completion: @Sendable @escaping (Result<MTGSet, Error>) -> Void
  ) {
    let request = GetSet(identifier: identifier)
    networkService.request(request, as: MTGSet.self, completion: completion)
  }

  /// Get the rulings for a specific card.
  ///
  /// [Scryfall documentation](https://scryfall.com/docs/api/rulings)
  ///
  /// See ``Card/Ruling/Identifier`` for more information on ruling identifiers
  ///
  /// - Parameters:
  ///   - identifier: An identifier for the ruling you wish to retrieve
  ///   - completion: A function/block to call when the request is complete
  public func getRulings(
    _ identifier: Card.Ruling.Identifier,
    completion: @Sendable @escaping (Result<ObjectList<Card.Ruling>, Error>) -> Void
  ) {
    let request = GetRulings(identifier: identifier)
    networkService.request(request, as: ObjectList<Card.Ruling>.self, completion: completion)
  }

  /// Get all MTG symbology
  ///
  /// [Scryfall documentation](https://scryfall.com/docs/api/card-symbols/all)
  ///
  /// - Parameter completion: A function/block to call when the request is complete
  public func getSymbology(
    completion: @Sendable @escaping (Result<ObjectList<Card.Symbol>, Error>) -> Void
  ) {
    networkService.request(GetSymbology(), as: ObjectList<Card.Symbol>.self, completion: completion)
  }

  /// Parse a string representing a mana cost and retun Scryfall's interpretation
  ///
  /// [Scryfall documentation](https://scryfall.com/docs/api/card-symbols/parse-mana)
  ///
  /// - Parameters:
  ///   - cost: The string to parse
  ///   - completion: A function/block to call when the request is complete
  public func parseManaCost(
    _ cost: String, completion: @Sendable @escaping (Result<Card.ManaCost, Error>) -> Void
  ) {
    let request = ParseManaCost(cost: cost)
    networkService.request(request, as: Card.ManaCost.self, completion: completion)
  }
}
