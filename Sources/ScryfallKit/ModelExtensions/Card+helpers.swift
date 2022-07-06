//
//  Card+helpers.swift
//  ScryfallKit
//
//  Created by Jacob Hearst on 9/7/21.
//

import Foundation

extension Card {
    /** Get the URL for a specific image type
     - Parameter type: The desired image type
     - Parameter getSecondFace: Whether or not the second face of a card should be retrieved
     */
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
            print("No URI for image type \(type)")
            return nil
        }

        return URL(string: uri)
    }

    /** Get an image URL with backups in case the card doesn't have the desired ImageType
     For example: If you want the normal sized image uri but are okay with the large size if normal isn't available,
     you would call this method as: `getImageURL(types: [.normal, .large])`
     - Parameter types: A list of ImageTypes ordered by preference
     - Parameter getSecondFace: Whether or not the second face of a card should be retrieved
     */
    public func getImageURL(types: [ImageType], getSecondFace: Bool = false) -> URL? {
        for type in types {
            guard let url = getImageURL(type: type, getSecondFace: getSecondFace) else {
                continue
            }

            return url
        }

        return nil
    }

    /**
     Get the legality of a card in a given format
     - Parameter format: The format to get legality for
     - Returns: The legality of this card for the given format
     */
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


    /**
     Get an attribute for a multifaced card
     - Parameters:
     - keyPath: A KeyPath for the desired attribute
     - useSecondFace: Whether or not the attribute from the second face should be used
     - Returns: The requested property from the desired face
     */
    public func getAttributeForFace<PropType>(keyPath: KeyPath<CardFace, PropType>, useSecondFace: Bool) throws -> PropType {
        guard let faces = cardFaces else { throw ScryfallKitError.singleFacedCard }
        return useSecondFace ? faces[1][keyPath: keyPath] : faces[0][keyPath: keyPath]
    }
}
