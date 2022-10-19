//
//  Card+Prices.swift
//

extension Card {
    /// Daily price information for a Magic card
    public struct Prices: Codable, Hashable {
        public var tix: String?
        public var usd: String?
        public var usdFoil: String?
        public var eur: String?

        public init(tix: String? = nil, usd: String? = nil, usdFoil: String? = nil, eur: String? = nil) {
            self.tix = tix
            self.usd = usd
            self.usdFoil = usdFoil
            self.eur = eur
        }
    }
}
