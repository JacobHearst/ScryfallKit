//
//  ScryfallClient+Async.swift
//

import Foundation

@available(macOS 10.15.0, *, iOS 13.0.0, *)
extension ScryfallClient {
  /// Equivalent to ``searchCards(filters:unique:order:sortDirection:includeExtras:includeMultilingual:includeVariations:page:completion:)`` but with async/await syntax
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
    try await withCheckedThrowingContinuation { continuation in
      searchCards(
        filters: filters,
        unique: unique,
        order: order,
        sortDirection: sortDirection,
        includeExtras: includeExtras,
        includeMultilingual: includeMultilingual,
        includeVariations: includeVariations,
        page: page
      ) { result in
        continuation.resume(with: result)
      }
    }
  }

  /// Equivalent to ``searchCards(query:unique:order:sortDirection:includeExtras:includeMultilingual:includeVariations:page:completion:)`` but with async/await syntax
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
      page: page)

    return try await networkService.request(request, as: ObjectList<Card>.self)
  }

  /// Equivalent to ``getCardByName(exact:set:completion:)`` but with async/await syntax
  public func getCardByName(exact: String, set: String? = nil) async throws -> Card {
    let request = GetCardNamed(exact: exact, set: set)
    return try await networkService.request(request, as: Card.self)
  }

  /// Equivalent to ``getCardByName(fuzzy:set:completion:)`` but with async/await syntax
  public func getCardByName(fuzzy: String, set: String? = nil) async throws -> Card {
    let request = GetCardNamed(fuzzy: fuzzy, set: set)
    return try await networkService.request(request, as: Card.self)
  }

  /// Equivalent to ``getCardNameAutocomplete(query:includeExtras:completion:)`` but with async/await syntax
  public func getCardNameAutocomplete(query: String, includeExtras: Bool? = nil) async throws
    -> Catalog
  {
    let request = GetCardAutocomplete(query: query, includeExtras: includeExtras)
    return try await networkService.request(request, as: Catalog.self)
  }

  /// Equivalent to ``getRandomCard(query:completion:)`` but with async/await syntax
  public func getRandomCard(query: String? = nil) async throws -> Card {
    let request = GetRandomCard(query: query)
    return try await networkService.request(request, as: Card.self)
  }

  /// Equivalent to ``getCard(identifier:completion:)`` but with async/await syntax
  public func getCard(identifier: Card.Identifier) async throws -> Card {
    let request = GetCard(identifier: identifier)
    return try await networkService.request(request, as: Card.self)
  }

  /// Equivalent to ``getCardCollection(identifiers:completion:)`` but with async/await syntax
  public func getCardCollection(identifiers: [Card.CollectionIdentifier]) async throws
    -> ObjectList<Card>
  {
    let request = GetCardCollection(identifiers: identifiers)
    return try await networkService.request(request, as: ObjectList<Card>.self)
  }

  /// Equivalent to ``getCatalog(catalogType:completion:)`` but with async/await syntax
  public func getCatalog(catalogType: Catalog.`Type`) async throws -> Catalog {
    let request = GetCatalog(catalogType: catalogType)
    return try await networkService.request(request, as: Catalog.self)
  }

  /// Equivalent to ``getSets(completion:)`` but with async/await syntax
  public func getSets() async throws -> ObjectList<MTGSet> {
    try await networkService.request(GetSets(), as: ObjectList<MTGSet>.self)
  }

  /// Equivalent to ``getSet(identifier:completion:)`` but with async/await syntax
  public func getSet(identifier: MTGSet.Identifier) async throws -> MTGSet {
    let request = GetSet(identifier: identifier)
    return try await networkService.request(request, as: MTGSet.self)
  }

  /// Equivalent to ``getRulings(_:completion:)`` but with async/await syntax
  public func getRulings(_ identifier: Card.Ruling.Identifier) async throws -> ObjectList<
    Card.Ruling
  > {
    let request = GetRulings(identifier: identifier)
    return try await networkService.request(request, as: ObjectList<Card.Ruling>.self)
  }

  /// Equivalent to ``getSymbology(completion:)`` but with async/await syntax
  public func getSymbology() async throws -> ObjectList<Card.Symbol> {
    try await networkService.request(GetSymbology(), as: ObjectList<Card.Symbol>.self)
  }

  /// Equivalent to ``parseManaCost(_:completion:)`` but with async/await syntax
  public func parseManaCost(_ cost: String) async throws -> Card.ManaCost {
    let request = ParseManaCost(cost: cost)
    return try await networkService.request(request, as: Card.ManaCost.self)
  }
}
