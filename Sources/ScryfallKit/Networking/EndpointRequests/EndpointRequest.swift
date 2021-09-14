//
//  File.swift
//  
//
//  Created by Jacob Hearst on 6/8/21.
//

import Foundation

protocol EndpointRequest {
    var path: String? { get }
    var queryParams: [URLQueryItem] { get }
    var requestMethod: RequestMethod { get }
    var body: Data? { get }
}

extension EndpointRequest {
    var urlRequest: URLRequest? {
        guard let path = path else {
            print("Couldn't get path for request")
            return nil
        }

        var urlComponents = URLComponents(string: "https://api.scryfall.com/\(path)")
        urlComponents?.queryItems = queryParams.compactMap { $0.value == nil ? nil : $0 }

        guard let url = urlComponents?.url else {
            print("Couldn't make url")
            return nil
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = requestMethod.rawValue
        urlRequest.httpBody = body
        if let bod = body {
            print(String(data: bod, encoding: .utf8)!)
        }
        return urlRequest
    }
}

enum RequestMethod: String {
    case GET, POST
}
