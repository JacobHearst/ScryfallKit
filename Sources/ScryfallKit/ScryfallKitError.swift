//
//  File.swift
//  
//
//  Created by Jacob Hearst on 6/8/21.
//

import Foundation

enum ScryfallKitError: Error, CustomStringConvertible {
    case invalidUrl
    case scryfallError(error: ScryfallError)
    case networkTimedOut(time: Int)
    case unexpectedNilResult

    var description: String {
        switch self {
        case .invalidUrl:
            return "Invalid URL"
        case .scryfallError(let error):
            return error.details
        case .networkTimedOut(let time):
            return "Network request timed out after \(time) seconds"
        case .unexpectedNilResult:
            return "Received unexpected nil result from network service"
        }
    }
}
