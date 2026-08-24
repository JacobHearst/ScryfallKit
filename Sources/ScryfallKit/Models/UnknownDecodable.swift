//
// UnknownDecodable.swift
//

/// A convenience protocol to reduce duplication of RawRepresentable and Decodable initializers
protocol UnknownDecodable: Decodable, CaseIterable, RawRepresentable where RawValue == String {
  static func unknown(_ rawValue: String) -> Self
}

extension UnknownDecodable {
  public init?(rawValue: String) {
    guard let match = Self.allCases.first(where: { $0.rawValue == rawValue }) else {
      return nil
    }

    self = match
  }

  public init(from decoder: any Decoder) throws {
    let rawValue = try decoder.singleValueContainer().decode(String.self)
    self = .init(rawValue: rawValue) ?? .unknown(rawValue)
  }
}

extension Card.BorderColor: UnknownDecodable {}
extension Card.Finish: UnknownDecodable {}
extension Card.Frame: UnknownDecodable {}
extension Card.FrameEffect: UnknownDecodable {}
extension Card.ProducedColor: UnknownDecodable {}
extension Card.Layout: UnknownDecodable {}
extension Card.RelatedCard.Component: UnknownDecodable {}
extension Card.Ruling.Source: UnknownDecodable {}
extension Card.SecurityStamp: UnknownDecodable {}
extension Game: UnknownDecodable {}
extension MTGSet.Kind: UnknownDecodable {}
