//
//  File.swift
//  
//
//  Created by Jacob Hearst on 6/8/21.
//

import Foundation

struct SearchCards: EndpointRequest {
    var query: String
    var unique: UniqueMode?
    var order: SortMode?
    var dir: SortDirection?
    var include_extras: Bool?
    var include_multilingual: Bool?
    var include_variations: Bool?
    var page: Int?

    var body: Data? = nil
    var requestMethod: RequestMethod = .GET
    var path: String? = "cards/search"
    var queryParams: [URLQueryItem]

    init(
        query: String,
        unique: UniqueMode? = nil,
        order: SortMode? = nil,
        dir: SortDirection? = nil,
        include_extras: Bool? = nil,
        include_multilingual: Bool? = nil,
        include_variations: Bool? = nil,
        page: Int? = nil) {

        self.query = query
        self.unique = unique
        self.order = order
        self.dir = dir
        self.include_extras = include_extras
        self.include_multilingual = include_multilingual
        self.include_variations = include_variations
        self.page = page

        self.queryParams = [
            URLQueryItem(name: "q", value: query),
            URLQueryItem(name: "unique", value: unique?.rawValue),
            URLQueryItem(name: "order", value: order?.rawValue),
            URLQueryItem(name: "dir", value: dir?.rawValue),
            URLQueryItem(name: "include_extras", value: include_extras?.description),
            URLQueryItem(name: "include_multilingual", value: include_multilingual?.description),
            URLQueryItem(name: "include_variations", value: include_variations?.description),
            URLQueryItem(name: "page", value: page?.description),
        ]
    }
}

struct GetCardNamed: EndpointRequest {
    var exact: String?
    var fuzzy: String?
    var set: String?
    var backFace: Bool?
    var version: Card.ImageType?

    var body: Data? = nil
    var requestMethod: RequestMethod = .GET
    var path: String? = "cards/named"
    var queryParams: [URLQueryItem]

    init(
        exact: String? = nil,
        fuzzy: String? = nil,
        set: String? = nil,
        backFace: Bool = false,
        version: Card.ImageType? = nil) {

        self.exact = exact
        self.fuzzy = fuzzy
        self.set = set
        self.backFace = backFace
        self.version = version
        var queryParams = [
            URLQueryItem(name: "exact", value: exact),
            URLQueryItem(name: "fuzzy", value: fuzzy),
            URLQueryItem(name: "set", value: set),
            URLQueryItem(name: "version", value: version?.rawValue),
        ]

        guard exact != nil || fuzzy != nil else {
            self.queryParams = queryParams
            print("Searching cards by name requires either a fuzzy or an exact param")
            return
        }

        guard backFace else {
            self.queryParams = queryParams
            return
        }

        queryParams.append(URLQueryItem(name: "face", value: "back"))
        self.queryParams = queryParams
    }
}

struct GetCardAutocomplete: EndpointRequest {
    var query: String
    var include_extras: Bool?

    var body: Data? = nil
    var requestMethod: RequestMethod = .GET
    var path: String? = "cards/autocomplete"
    var queryParams: [URLQueryItem]

    init(query: String, include_extras: Bool? = nil) {
        self.query = query
        self.include_extras = include_extras
        self.queryParams = [
            URLQueryItem(name: "q", value: query),
            URLQueryItem(name: "include_extras", value: include_extras?.description)
        ]
    }
}

struct GetRandomCard: EndpointRequest {
    var query: String?
    var backFace: Bool
    var version: Card.ImageType?

    var body: Data? = nil
    var requestMethod: RequestMethod = .GET
    var path: String? = "cards/random"
    var queryParams: [URLQueryItem]

    init(query: String?, backFace: Bool = false, version: Card.ImageType? = nil) {
        self.query = query
        self.backFace = backFace
        self.version = version

        var queryParams = [
            URLQueryItem(name: "q", value: query),
            URLQueryItem(name: "version", value: version?.rawValue),
        ]

        guard backFace else {
            self.queryParams = queryParams
            return
        }

        queryParams.append(URLQueryItem(name: "face", value: "back"))
        self.queryParams = queryParams
    }
}

struct GetCard: EndpointRequest {
    var identifier: Card.Identifier
    var backFace: Bool

    var path: String? {
        switch identifier {
        case .scryfallID(let id):
            return "cards/\(id)"
        case .setCodeCollectorNo(let setCode, let collectorNumber, let lang):
            let pathStr = "cards/\(setCode)/\(collectorNumber)"
            guard let language = lang else { return pathStr }
            return "\(pathStr)/\(language)"
        default:
            // This guard should never trip. The only card identifier that doesn't have provider/id
            // is the set code/collector no identifier
            guard
                let provider = identifier.provider,
                let id = identifier.id else {
                print("Provided identifier doesn't have a provider or doesn't have an id")

                return nil
            }

            return "cards/\(provider)/\(id)"
        }
    }
    var queryParams: [URLQueryItem]
    var requestMethod: RequestMethod = .GET
    var body: Data? = nil

    init(identifier: Card.Identifier, backFace: Bool = false) {
        self.identifier = identifier
        self.backFace = backFace

        guard backFace else {
            self.queryParams = []
            return
        }
        self.queryParams = [
            URLQueryItem(name: "face", value: "back")
        ]
    }
}
