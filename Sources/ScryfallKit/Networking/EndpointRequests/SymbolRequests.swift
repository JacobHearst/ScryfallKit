//
//  SymbolRequests.swift
//  ScryfallKit
//
//  Created by Jacob Hearst on 8/22/21.
//

import Foundation

struct GetSymbology: EndpointRequest {
    var path: String? = "symbology"
    var queryParams: [URLQueryItem] = []
    var requestMethod: RequestMethod = .GET
    var body: Data? = nil
}

struct ParseManaCost: EndpointRequest {
    // Request params
    var cost: String

    // Protocol vars
    var path: String? = "symbology/parse-mana"
    var queryParams: [URLQueryItem]
    var requestMethod: RequestMethod = .GET
    var body: Data? = nil

    init(cost: String) {
        self.cost = cost
        self.queryParams = [
            URLQueryItem(name: "cost", value: cost)
        ]
    }
}
