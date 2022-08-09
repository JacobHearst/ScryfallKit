//
//  SetEndpointRequest.swift
//  ScryfallKit
//
//  Created by Jacob Hearst on 8/22/21.
//

import Foundation

struct GetSets: EndpointRequest {
    var path: String? = "sets"
    var queryParams: [URLQueryItem] = []
    var requestMethod: RequestMethod = .GET
    var body: Data? = nil
}

struct GetSet: EndpointRequest {
    var identifier: MTGSet.Identifier

    var path: String? {
        switch self.identifier {
        case .code(let code):
            return "sets/\(code)"
        case .scryfallID(let id):
            return "sets/\(id)"
        case .tcgPlayerID(let id):
            return "sets/tcglayer/\(id)"
        }
    }
    var queryParams: [URLQueryItem] = []
    var requestMethod: RequestMethod = .GET
    var body: Data? = nil
}
