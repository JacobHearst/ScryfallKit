//
//  SymbolRequests.swift
//

import Foundation

struct GetSymbology: EndpointRequest {
  var path = "symbology"
  var queryParams: [URLQueryItem] = []
  var requestMethod: RequestMethod = .GET
  var body: Data?
}

struct ParseManaCost: EndpointRequest {
  // Request params
  var cost: String

  // Protocol vars
  var path = "symbology/parse-mana"
  var queryParams: [URLQueryItem]
  var requestMethod: RequestMethod = .GET
  var body: Data?

  init(cost: String) {
    self.cost = cost
    self.queryParams = [
      URLQueryItem(name: "cost", value: cost)
    ]
  }
}
