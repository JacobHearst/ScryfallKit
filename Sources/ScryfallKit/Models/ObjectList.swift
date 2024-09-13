//
//  ObjectList.swift
//

import Foundation

/// A sequence of Scryfall objects. May be paginated
///
/// [Scryfall documentation](https://scryfall.com/docs/api/lists)
public struct ObjectList<T: Codable>: Codable, Sendable where T: Sendable {
  /// The data contained in the list
  public var data: [T]
  /// True if there's a next page, nil if there's only one page
  public var hasMore: Bool?
  /// If there is a page beyond the current page, this field will contain a full API URI to that page. You may submit a HTTP GET request to that URI to continue paginating forward on this List.
  public var nextPage: String?
  /// If this is a list of Card objects, this field will contain the total number of cards found across all pages.
  public var totalCards: Int?
  /// An array of human-readable warnings issued when generating this list, as strings.
  ///
  /// Warnings are non-fatal issues that the API discovered with your input. In general, they indicate that the List will not contain the all of the information you requested. You should fix the warnings and re-submit your request.
  public var warnings: [String]?

  public init(
    data: [T], hasMore: Bool? = nil, nextPage: String? = nil, totalCards: Int? = nil,
    warnings: [String]? = nil
  ) {
    self.data = data
    self.hasMore = hasMore
    self.nextPage = nextPage
    self.totalCards = totalCards
    self.warnings = warnings
  }
}
