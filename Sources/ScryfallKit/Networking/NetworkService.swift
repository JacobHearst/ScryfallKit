//
//  NetworkService.swift
//  
//
//  Created by Jacob Hearst on 8/18/21.
//

import Foundation

public enum NetworkLogLevel {
    case minimal, verbose
}

protocol NetworkServiceProtocol {
    func request<T : Decodable>(_ request: EndpointRequest, as type: T.Type, completion: @escaping (Result<T, Error>) -> Void)
    @available(macOS 10.15.0, *, iOS 13.0.0, *)
    func request<T : Decodable>(_ request: EndpointRequest, as type: T.Type) async throws -> T
}

struct NetworkService: NetworkServiceProtocol {
    var logLevel: NetworkLogLevel

    @available(*, renamed: "request(_:as:)")
    func request<T : Decodable>(_ request: EndpointRequest, as type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        guard let urlRequest = request.urlRequest else {
            print("Invalid url request")
            completion(.failure(ScryfallKitError.invalidUrl))
            return
        }

        if let body = urlRequest.httpBody, let JSONString = String(data: body, encoding: String.Encoding.utf8) {
            print("Sending request with body:")
            print(JSONString)
        }

        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard error == nil else {
                print("Error: \(String(describing: error))")
                completion(.failure(error!))
                return
            }

            guard let content = data else {
                print("Data was nil")
                return
            }

            let httpStatus = (response as! HTTPURLResponse).statusCode
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase

                if (200..<300).contains(httpStatus) {
                    print("Received response")
                    if logLevel == .verbose {
                        let responseBody = String(data: content, encoding: .utf8)
                        print(responseBody ?? "Couldn't represent response body as string")
                    }

                    let result = try decoder.decode(type, from: content)
                    completion(.success(result))
                } else {
                    let httpError = try decoder.decode(ScryfallError.self, from: content)
                    print(httpError)
                    completion(.failure(ScryfallKitError.scryfallError(error: httpError)))
                }
            } catch {
                print(error)
                completion(.failure(error))
            }
        }

        print("Making request to: '\(String(describing: urlRequest.url?.absoluteString))'")
        if logLevel == .verbose {
            if let body = urlRequest.httpBody {
                print(String(data: body, encoding: .utf8) ?? "Couldn't represent request body as string")
            } else {
                print("No body")
            }
        }
        task.resume()
    }

    @available(macOS 10.15.0, *, iOS 13.0.0, *)
    func request<T : Decodable>(_ request: EndpointRequest, as type: T.Type) async throws -> T {
        try await withCheckedThrowingContinuation { continuation in
            self.request(request, as: type) { result in
                continuation.resume(with: result)
            }
        }
    }

}
