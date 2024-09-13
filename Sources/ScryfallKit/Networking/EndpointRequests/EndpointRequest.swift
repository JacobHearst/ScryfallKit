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
    if !queryParams.isEmpty {
      urlComponents?.queryItems = queryParams.compactMap { $0.value == nil ? nil : $0 }
    }

    guard let url = urlComponents?.url else {
      if #available(iOS 14.0, macOS 11.0, *) {
        Logger.main.error("Couldn't make url")
      } else {
        print("Couldn't make url")
      }
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
