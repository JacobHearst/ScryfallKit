//
//  SearchCards.swift
//

import Foundation
import OSLog

struct SearchCards: EndpointRequest {
  var body: Data?
  var requestMethod: RequestMethod = .GET
  var path = "cards/search"
  var queryParams: [URLQueryItem]

  init(
    query: String,
    unique: UniqueMode? = nil,
    order: SortMode? = nil,
    dir: SortDirection? = nil,
    includeExtras: Bool? = nil,
    includeMultilingual: Bool? = nil,
    includeVariations: Bool? = nil,
    page: Int? = nil
  ) {

    self.queryParams = [
      URLQueryItem(name: "q", value: query),
      URLQueryItem(name: "unique", value: unique?.rawValue),
      URLQueryItem(name: "order", value: order?.rawValue),
      URLQueryItem(name: "dir", value: dir?.rawValue),
      URLQueryItem(name: "include_extras", value: includeExtras?.description),
      URLQueryItem(name: "include_multilingual", value: includeMultilingual?.description),
      URLQueryItem(name: "include_variations", value: includeVariations?.description),
      URLQueryItem(name: "page", value: page?.description),
    ]
  }
}

struct GetCardNamed: EndpointRequest {
  var body: Data?
  var requestMethod: RequestMethod = .GET
  var path = "cards/named"
  var queryParams: [URLQueryItem]

  init(exact: String? = nil, fuzzy: String? = nil, set: String? = nil) {
    queryParams = [
      URLQueryItem(name: "exact", value: exact),
      URLQueryItem(name: "fuzzy", value: fuzzy),
      URLQueryItem(name: "set", value: set),
    ]
  }
}

struct GetCardAutocomplete: EndpointRequest {
  var body: Data?
  var requestMethod: RequestMethod = .GET
  var path = "cards/autocomplete"
  var queryParams: [URLQueryItem]

  init(query: String, includeExtras: Bool? = nil) {
    self.queryParams = [
      URLQueryItem(name: "q", value: query),
      URLQueryItem(name: "include_extras", value: includeExtras?.description),
    ]
  }
}

struct GetRandomCard: EndpointRequest {
  var body: Data?
  var requestMethod: RequestMethod = .GET
  var path = "cards/random"
  var queryParams: [URLQueryItem]

  init(query: String?) {
    queryParams = [
      URLQueryItem(name: "q", value: query)
    ]
  }
}

struct GetCard: EndpointRequest {
  let identifier: Card.Identifier

  var path: String {
    switch identifier {
    case .scryfallID(let id):
      return "cards/\(id)"
    case .setCodeCollectorNo(let setCode, let collectorNumber, let lang):
      let pathStr = "cards/\(setCode)/\(collectorNumber)"
      guard let language = lang else { return pathStr }
      return "\(pathStr)/\(language)"
    default:
      // This guard should never trip. The only card identifier that doesn't have provider/id is the set code/collector
      guard let id = identifier.id else {
        if #available(iOS 14.0, macOS 11.0, *) {
          Logger.main.error("Provided identifier doesn't have a provider or doesn't have an id")
        } else {
          print("Provided identifier doesn't have a provider or doesn't have an id")
        }

        fatalError(
          "Encountered a situation that shouldn't be possible: Card identifier's id property was nil"
        )
      }

      return "cards/\(identifier.provider)/\(id)"
    }
  }

  var queryParams = [URLQueryItem]()
  var requestMethod: RequestMethod = .GET
  var body: Data?
}

struct GetCardCollection: EndpointRequest {
  var path = "cards/collection"
  var queryParams: [URLQueryItem] = []
  var requestMethod: RequestMethod = .POST
  var body: Data?

  init(identifiers: [Card.CollectionIdentifier]) {
    let identifierJSON = identifiers.map { $0.json }
    let requestBody: [String: [[String: String]]] = ["identifiers": identifierJSON]

    do {
      body = try JSONSerialization.data(withJSONObject: requestBody)
    } catch {
      if #available(iOS 14.0, macOS 11.0, *) {
        Logger.main.error("Errored serializing dict to JSON for GetCardCollection request")
      } else {
        print("Errored serializing dict to JSON for GetCardCollection request")
      }
    }
  }
}
