//
//  CatalogEndpointRequest.swift
//

import Foundation

struct GetCatalog: EndpointRequest {
  var catalogType: Catalog.`Type`

  var path: String {
    return "catalog/\(catalogType.rawValue)"
  }

  var queryParams: [URLQueryItem] = []
  var requestMethod: RequestMethod = .GET
  var body: Data?
}
