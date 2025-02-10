//
//  NetworkService.swift
//

import Foundation
import OSLog

/// An enum representing the two available levels of log verbosity
public enum NetworkLogLevel: Sendable {
  /// Only log errors
  case error
  /// Log when errors occur or a network request is made
  case minimal
  /// Log the bodies of requests and responses
  case verbose
}

protocol NetworkServiceProtocol: Sendable {
  func request<T: Decodable>(
    _ request: EndpointRequest,
    as type: T.Type,
    completion: @Sendable @escaping (Result<T, Error>) -> Void
  )
  @available(macOS 10.15.0, *, iOS 13.0.0, *)
  func request<T: Decodable>(_ request: EndpointRequest, as type: T.Type) async throws -> T
}

struct NetworkService: NetworkServiceProtocol, Sendable {
  var logLevel: NetworkLogLevel

  func request<T: Decodable>(
    _ request: EndpointRequest, as type: T.Type,
    completion: @Sendable @escaping (Result<T, Error>) -> Void
  ) {
    guard let urlRequest = request.urlRequest else {
      Logger.network.error("Invalid url request")
      completion(.failure(ScryfallKitError.invalidUrl))
      return
    }

    if logLevel == .verbose, let body = urlRequest.httpBody,
      let JSONString = String(data: body, encoding: String.Encoding.utf8)
    {
      Logger.network.debug("Sending request with body:")
      Logger.network.debug("\(JSONString)")
    }

    let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
      do {
        let result = try handle(dataType: type, data: data, response: response, error: error)
        completion(.success(result))
      } catch {
        completion(.failure(error))
      }
    }

    Logger.network.debug(
      "Making request to: '\(String(describing: urlRequest.url?.absoluteString))'")

    task.resume()
  }

  func handle<T: Decodable>(
    dataType: T.Type,
    data: Data?,
    response: URLResponse?,
    error: Error?
  ) throws -> T {
    if let error = error {
      throw error
    }

    guard let content = data else {
      throw ScryfallKitError.noDataReturned
    }

    guard let httpStatus = (response as? HTTPURLResponse)?.statusCode else {
      throw ScryfallKitError.failedToCast("httpStatus property of response to HTTPURLResponse")
    }

    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase

    if (200..<300).contains(httpStatus) {
      if logLevel == .verbose {
        let responseBody = String(data: content, encoding: .utf8)
        Logger.network.debug("\(responseBody ?? "Couldn't represent response body as string")")
      }

      return try decoder.decode(dataType, from: content)
    } else {
      let httpError = try decoder.decode(ScryfallError.self, from: content)
      throw ScryfallKitError.scryfallError(httpError)
    }
  }

  func request<T: Decodable>(_ request: EndpointRequest, as type: T.Type) async throws -> T
  where T: Sendable {
    try await withCheckedThrowingContinuation { continuation in
      self.request(request, as: type) { result in
        continuation.resume(with: result)
      }
    }
  }
}
