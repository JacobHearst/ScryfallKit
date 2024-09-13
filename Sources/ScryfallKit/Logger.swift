//
// Logger.swift
//

import Foundation
import OSLog

@available(macOS 11.0, *)
@available(iOS 14.0, *)
extension Logger {
  static let subsystem = "dev.hearst.scryfallkit"
  static let main = Logger(subsystem: subsystem, category: "ScryfallKit")
  static let client = Logger(subsystem: subsystem, category: "ScryfallClient")
  static let network = Logger(subsystem: subsystem, category: "Network")
  static let decoder = Logger(subsystem: subsystem, category: "Decoder")
}
