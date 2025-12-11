//
//  Card+Legalities.swift
//

import Foundation

extension Card {
  /// The legality of a Magic card in each format
  public struct Legalities: Codable, Hashable, Sendable {
    public let standard: Legality?
    public let historic: Legality?
    public let pioneer: Legality?
    public let modern: Legality?
    public let legacy: Legality?
    public let pauper: Legality?
    public let vintage: Legality?
    public let penny: Legality?
    public let commander: Legality?
    public let brawl: Legality?
    public let future: Legality?
    public let timeless: Legality?
    public let gladiator: Legality?
    public let oathbreaker: Legality?
    public let standardbrawl: Legality?
    public let alchemy: Legality?
    public let paupercommander: Legality?
    public let duel: Legality?
    public let oldschool: Legality?
    public let premodern: Legality?
    public let predh: Legality?

    public init(
      standard: Legality?,
      historic: Legality?,
      pioneer: Legality?,
      modern: Legality?,
      legacy: Legality?,
      pauper: Legality?,
      vintage: Legality?,
      penny: Legality?,
      commander: Legality?,
      brawl: Legality?,
      future: Legality?,
      timeless: Legality?,
      gladiator: Legality?,
      oathbreaker: Legality?,
      standardbrawl: Legality?,
      alchemy: Legality?,
      paupercommander: Legality?,
      duel: Legality?,
      oldschool: Legality?,
      premodern: Legality?,
      predh: Legality?,
    ) {
      self.standard = standard
      self.historic = historic
      self.pioneer = pioneer
      self.modern = modern
      self.legacy = legacy
      self.pauper = pauper
      self.vintage = vintage
      self.penny = penny
      self.commander = commander
      self.brawl = brawl
      self.future = future
      self.timeless = timeless
      self.gladiator = gladiator
      self.oathbreaker = oathbreaker
      self.standardbrawl = standardbrawl
      self.alchemy = alchemy
      self.paupercommander = paupercommander
      self.duel = duel
      self.oldschool = oldschool
      self.premodern = premodern
      self.predh = predh
    }
  }
}
