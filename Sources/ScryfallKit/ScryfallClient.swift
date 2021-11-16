import Foundation

public struct ScryfallClient {
    private var networkLogLevel: NetworkLogLevel
    private var networkService: NetworkServiceProtocol

    public init(networkLogLevel: NetworkLogLevel = .minimal) {
        self.networkLogLevel = networkLogLevel
        self.networkService = NetworkService(logLevel: networkLogLevel)
    }

    public func searchCards(
        filters: [FieldFilter],
        unique: UniqueMode? = nil,
        order: SortMode? = nil,
        sortDirection: SortDirection? = nil,
        include_extras: Bool? = nil,
        include_multilingual: Bool? = nil,
        include_variations: Bool? = nil,
        page: Int? = nil,
        completion: @escaping (Result<List<Card>, Error>) -> Void) {

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

        networkService.request(request, as: List<Card>.self) { result in
            switch result {
            case .success(let cards):
                completion(.success(cards))
            case.failure(let error):
                completion(.failure(error))
            }
        }
    }

    public func searchCards(
        query: String,
        unique: UniqueMode? = nil,
        order: SortMode? = nil,
        sortDirection: SortDirection? = nil,
        include_extras: Bool? = nil,
        include_multilingual: Bool? = nil,
        include_variations: Bool? = nil,
        page: Int? = nil,
        completion: @escaping (Result<List<Card>, Error>) -> Void) {

        let request = SearchCards(
            query: query,
            unique: unique,
            order: order,
            dir: sortDirection,
            include_extras: include_extras,
            include_multilingual: include_multilingual,
            include_variations: include_variations,
            page: page)

        networkService.request(request, as: List<Card>.self) { result in
            switch result {
            case .success(let cards):
                completion(.success(cards))
            case.failure(let error):
                completion(.failure(error))
            }
        }
    }

    public func getCardByName(
        exact: String,
        set: String? = nil,
        backFace: Bool = false,
        version: Card.ImageType? = nil,
        completion: @escaping (Result<Card, Error>) -> Void) {

        let request = GetCardNamed(
            exact: exact,
            set: set,
            backFace: backFace,
            version: version)

        networkService.request(request, as: Card.self) { result in
            switch result {
            case .success(let card):
                completion(.success(card))
            case.failure(let error):
                completion(.failure(error))
            }
        }
    }

    public func getCardByName(
        fuzzy: String,
        set: String? = nil,
        backFace: Bool = false,
        version: Card.ImageType? = nil,
        completion: @escaping (Result<Card, Error>) -> Void) {

        let request = GetCardNamed(
            fuzzy: fuzzy,
            set: set,
            backFace: backFace,
            version: version)

        networkService.request(request, as: Card.self) { result in
            switch result {
            case .success(let card):
                completion(.success(card))
            case.failure(let error):
                completion(.failure(error))
            }
        }
    }

    public func getCardNameAutocomplete(
        query: String,
        include_extras: Bool? = nil,
        completion: @escaping (Result<[String], Error>) -> Void) {

        let request = GetCardAutocomplete(query: query, include_extras: include_extras)

        networkService.request(request, as: Catalog.self) { result in
            switch result {
            case .success(let catalog):
                completion(.success(catalog.data))
            case.failure(let error):
                completion(.failure(error))
            }
        }
    }

    public func getRandomCard(
        query: String? = nil,
        backFace: Bool = false,
        version: Card.ImageType? = nil,
        completion: @escaping (Result<Card, Error>) -> Void) {

        let request = GetRandomCard(
            query: query,
            backFace: backFace,
            version: version)

        networkService.request(request, as: Card.self) { result in
            switch result {
            case .success(let card):
                completion(.success(card))
            case.failure(let error):
                completion(.failure(error))
            }
        }
    }

    public func getCard(
        identifier: Card.Identifier,
        backFace: Bool = false,
        completion: @escaping (Result<Card, Error>) -> Void) {

        let request = GetCard(identifier: identifier, backFace: backFace)

        networkService.request(request, as: Card.self) { result in
            switch result {
            case .success(let card):
                completion(.success(card))
            case.failure(let error):
                completion(.failure(error))
            }
        }
    }

    public func getCatalog(catalogType: Catalog.`Type`, completion: @escaping (Result<Catalog, Error>) -> Void) {
        let request = GetCatalog(catalogType: catalogType)

        networkService.request(request, as: Catalog.self) { result in
            switch result {
            case .success(let catalog):
                completion(.success(catalog))
            case.failure(let error):
                completion(.failure(error))
            }
        }
    }

    public func getSets(completion: @escaping (Result<List<Set>, Error>) -> Void) {
        networkService.request(GetSets(), as: List<Set>.self) { result in
            switch result {
            case .success(let sets):
                completion(.success(sets))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    public func getSet(identifier: Set.Identifier, completion: @escaping (Result<Set, Error>) -> Void) {
        let request = GetSet(identifier: identifier)

        networkService.request(request, as: Set.self) { result in
            switch result {
            case .success(let set):
                completion(.success(set))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    public func getRulings(_ identifier: Ruling.Identifier, completion: @escaping (Result<List<Ruling>, Error>) -> Void) {
        let request = GetRulings(identifier: identifier)

        networkService.request(request, as: List<Ruling>.self) { result in
            switch result {
            case .success(let rulings):
                completion(.success(rulings))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    public func getSymbology(completion: @escaping (Result<List<CardSymbol>, Error>) -> Void) {
        networkService.request(GetSymbology(), as: List<CardSymbol>.self) { result in
            switch result {
            case .success(let symbols):
                completion(.success(symbols))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    public func parseManaCost(_ cost: String, completion: @escaping (Result<ManaCost, Error>) -> Void) {
        let request = ParseManaCost(cost: cost)

        networkService.request(request, as: ManaCost.self) { result in
            switch result {
            case .success(let manaCost):
                completion(.success(manaCost))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
