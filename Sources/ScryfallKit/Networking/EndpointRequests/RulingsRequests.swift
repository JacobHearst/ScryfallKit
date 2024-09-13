//
//  RulingsRequests.swift
//

import Foundation

struct GetRulings: EndpointRequest {
  var identifier: Card.Ruling.Identifier

  var path: String {
    switch identifier {
    case .multiverseID(let id):
      return "cards/multiverse/\(id)/rulings"
    case .mtgoID(let id):
      return "cards/mtgo/\(id)/rulings"
    case .arenaID(let id):
      return "cards/arena/\(id)/rulings"
    case .collectorNumberSet(let collectorNumber, let set):
      return "cards/\(set)/\(collectorNumber)/rulings"
    case .scryfallID(let id):
      return "cards/\(id)/rulings"
    }
  }
  var queryParams: [URLQueryItem] = []
  var requestMethod: RequestMethod = .GET
  var body: Data?
}
