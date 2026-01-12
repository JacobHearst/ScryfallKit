//
//  EndpointRequest.swift
//

import Foundation
import OSLog

protocol EndpointRequest {
  var path: String { get }
  var queryParams: [URLQueryItem] { get }
  var requestMethod: RequestMethod { get }
  var body: Data? { get }
}

extension EndpointRequest {
  var urlRequest: URLRequest? {
    var urlComponents = URLComponents(string: "https://api.scryfall.com/\(path)")
    urlComponents?.queryItems = queryParams.compactMap { $0.value == nil ? nil : $0 }
    let queryItems = urlComponents?.queryItems
    urlComponents?.percentEncodedQueryItems = queryItems?.map {
      URLQueryItem(name: $0.name, value: $0.value?.addingPercentEncoding(withAllowedCharacters: .alphanumerics))
    }

    guard let url = urlComponents?.url else {
      return nil
    }

    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = requestMethod.rawValue
    urlRequest.httpBody = body
    urlRequest.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")

    return urlRequest
  }
}

enum RequestMethod: String {
  case GET, POST
}
