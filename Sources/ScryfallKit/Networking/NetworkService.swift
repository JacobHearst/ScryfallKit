//
//  NetworkService.swift
//

import Foundation
import OSLog

protocol NetworkServiceProtocol: Sendable {
  func request<T: Decodable & Sendable>(_ request: EndpointRequest, as type: T.Type) async throws
    -> T
}

struct NetworkService: NetworkServiceProtocol, Sendable {
  let userAgent: String?
  let logger: Logger?
  let rateLimiter: RateLimiter?

  init(userAgent: String?, logger: Logger?, rateLimiter: RateLimiter?) {
    self.userAgent = userAgent
    self.logger = logger
    self.rateLimiter = rateLimiter
  }

  func request<T: Decodable & Sendable>(_ request: EndpointRequest, as type: T.Type) async throws
    -> T
  {
    guard var urlRequest = request.urlRequest else {
      logger?.error("Invalid url request")
      throw ScryfallKitError.invalidUrl
    }

    if let userAgent {
      urlRequest.setValue(userAgent, forHTTPHeaderField: "User-Agent")
    }

    await rateLimiter?.waitIfNeeded()

    logger?.trace("Starting request: \(urlRequest.debugDescription)")
    logger?.trace("Making request to: '\(String(describing: urlRequest.url?.absoluteString))'")
    let (data, response) = try await URLSession.shared.data(for: urlRequest)
    return try handle(dataType: type, data: data, response: response)
  }

  func handle<T: Decodable>(dataType: T.Type, data: Data, response: URLResponse) throws -> T {
    guard let httpStatus = (response as? HTTPURLResponse)?.statusCode else {
      throw ScryfallKitError.failedToCast("httpStatus property of response to HTTPURLResponse")
    }

    logger?.debug(
      "HTTP \(httpStatus): \(String(data: data, encoding: .utf8) ?? "Couldn't represent response body as string")"
    )

    let content = data

    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase

    if (200..<300).contains(httpStatus) {
      do {
        return try decoder.decode(dataType, from: content)
      } catch {
        throw ScryfallKitError.failedToDecode(content)
      }
    } else {
      let httpError: ScryfallError
      do {
        httpError = try decoder.decode(ScryfallError.self, from: content)
      } catch {
        throw ScryfallKitError.httpError(httpStatus, content)
      }
      throw ScryfallKitError.scryfallError(httpError)
    }
  }
}
