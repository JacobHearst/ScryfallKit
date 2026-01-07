//
//  NetworkService.swift
//

import Foundation
import OSLog

protocol NetworkServiceProtocol: Sendable {
  func request<T: Decodable>(
    _ request: EndpointRequest,
    as type: T.Type,
    completion: @Sendable @escaping (Result<T, Error>) -> Void
  )
  func request<T: Decodable>(_ request: EndpointRequest, as type: T.Type) async throws -> T
}

struct NetworkService: NetworkServiceProtocol, Sendable {
  let logger: Logger?

  init(logger: Logger?) {
    self.logger = logger
  }

  func request<T: Decodable & Sendable>(
    _ request: EndpointRequest, as type: T.Type,
    completion: @Sendable @escaping (Result<T, Error>) -> Void
  ) {
    guard let urlRequest = request.urlRequest else {
      logger?.error("Invalid url request")
      completion(.failure(ScryfallKitError.invalidUrl))
      return
    }

    logger?.trace("Starting request: \(urlRequest.debugDescription)")
    let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
      do {
        let result = try handle(dataType: type, data: data, response: response, error: error)
        completion(.success(result))
      } catch {
        completion(.failure(error))
      }
    }

    logger?.trace("Making request to: '\(String(describing: urlRequest.url?.absoluteString))'")
    task.resume()
  }

  func handle<T: Decodable>(dataType: T.Type, data: Data?, response: URLResponse?, error: Error?)
    throws -> T
  {
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
      let responseBody = String(data: content, encoding: .utf8)
      logger?.debug("\(responseBody ?? "Couldn't represent response body as string")")
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
