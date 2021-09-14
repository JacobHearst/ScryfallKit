//
//  Card+Utilities.swift
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
}
