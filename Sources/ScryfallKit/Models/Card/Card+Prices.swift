//
//  Card+Prices.swift
//

extension Card {
  /// Daily price information for a Magic card
  public struct Prices: Codable, Hashable, Sendable {
    /// The price of this card in tix
    public var tix: String?
    /// The price of this card in usd
    public var usd: String?
    /// The price of this card's foil printing in usd
    public var usdFoil: String?
    /// The price of this card's etched printing in usd
    public var usdEtched: String?
    /// The price of this card in eur.
    public var eur: String?

    public init(tix: String? = nil, usd: String? = nil, usdFoil: String? = nil, usdEtched: String? = nil, eur: String? = nil)
    {
      self.tix = tix
      self.usd = usd
      self.usdFoil = usdFoil
      self.usdEtched = usdEtched
      self.eur = eur
    }
  }
}
