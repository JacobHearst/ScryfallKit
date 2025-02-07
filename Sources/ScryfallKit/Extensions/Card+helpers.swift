//
//  Card+helpers.swift
//  ScryfallKit
//
//  Created by Jacob Hearst on 9/7/21.
//

import Foundation
import OSLog

extension Card {
  /// Get the legality of a card in a given format
  /// - Parameter format: The format to get legality for
  /// - Returns: The legality of this card for the given format
  public func getLegality(for format: Format) -> Legality {
    switch format {
    case .brawl:
      return legalities.brawl ?? .notLegal
    case .standard:
      return legalities.standard ?? .notLegal
    case .historic:
      return legalities.historic ?? .notLegal
    case .pioneer:
      return legalities.pioneer ?? .notLegal
    case .modern:
      return legalities.modern ?? .notLegal
    case .legacy:
      return legalities.legacy ?? .notLegal
    case .pauper:
      return legalities.pauper ?? .notLegal
    case .vintage:
      return legalities.vintage ?? .notLegal
    case .penny:
      return legalities.penny ?? .notLegal
    case .commander:
      return legalities.commander ?? .notLegal
    }
  }

  /// Get the price string for a given currency
  /// - Parameter type: The currency you want the price string for
  /// - Returns: The price string, if present. Nil if not
  public func getPrice(for currency: Currency) -> String? {
    switch currency {
    case .usd: return prices.usd
    case .eur: return prices.eur
    case .tix: return prices.tix
    case .usdFoil: return prices.usdFoil
    case .usdEtched: return prices.usdEtched
    }
  }
}

// Multifaced helpers
extension Card {
  /// Get an attribute for a multifaced card
  /// - Parameters:
  ///   - keyPath: A KeyPath for the desired attribute
  ///   - useSecondFace: Whether or not the attribute from the second face should be used
  /// - Returns: The requested property from the desired face
  public func getAttributeForFace<PropType>(keyPath: KeyPath<Face, PropType>, useSecondFace: Bool)
    throws -> PropType
  {
    guard let faces = cardFaces else { throw ScryfallKitError.singleFacedCard }
    return useSecondFace ? faces[1][keyPath: keyPath] : faces[0][keyPath: keyPath]
  }

  /// Get the URL for a specific image type
  /// - Parameters:
  ///   - type: The desired image type
  ///   -  getSecondFace: Whether or not the second face of a card should be retrieved
  public func getImageURL(type: ImageType, getSecondFace: Bool = false) -> URL? {
    var cardImageUris = self.imageUris

    if let faces = cardFaces {
      // Some cards have multiple "faces" but don't have unique images for those faces
      // Flip and split cards are examples of this
      let faceImageUris = getSecondFace ? faces[1].imageUris : faces[0].imageUris
      if faceImageUris != nil {
        cardImageUris = faceImageUris
      }
    }

    guard let uris = cardImageUris else {
      return nil
    }

    guard let uri = uris.uri(for: type) else {
      if #available(iOS 14.0, macOS 11.0, *) {
        Logger.main.error("No URI for image type \(type.rawValue)")
      } else {
        print("No URI for image type \(type)")
      }
      return nil
    }

    return URL(string: uri)
  }

  /// Get an image URL with backups in case the card doesn't have the desired ImageType
  ///
  /// Example: If you want the normal sized image uri but are okay with the large size if normal isn't available, you would call this method as: `getImageURL(types: [.normal, .large])`
  ///
  /// - Parameters:
  ///   - types: A list of ImageTypes ordered by preference
  ///   - getSecondFace: Whether or not the second face of a card should be retrieved
  public func getImageURL(types: [ImageType], getSecondFace: Bool = false) -> URL? {
    for type in types {
      guard let url = getImageURL(type: type, getSecondFace: getSecondFace) else {
        continue
      }

      return url
    }

    return nil
  }
}
