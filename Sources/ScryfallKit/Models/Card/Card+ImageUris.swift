//
//  Card+ImageUris.swift
//

import Foundation

extension Card {
    /// Image URIs for each ``Card/ImageType``
    public struct ImageUris: Codable, Hashable {
        private enum CodingKeys: String, CodingKey {
            case small
            case normal
            case large
            case png
            case artCrop = "art_crop"
            case borderCrop = "border_crop"
        }

        public let small: String?
        public let normal: String?
        public let large: String?
        public let png: String?
        public let artCrop: String?
        public let borderCrop: String?

        public init(small: String?, normal: String?, large: String?, png: String?, artCrop: String?, borderCrop: String?) {
            self.small = small
            self.normal = normal
            self.large = large
            self.png = png
            self.artCrop = artCrop
            self.borderCrop = borderCrop
        }

        /// Get the URI for a specific image type
        /// - Parameter type: The image type to retrieve the URI for
        /// - Returns: The URI, if present
        public func uri(for type: Card.ImageType) -> String? {
            switch type {
            case .artCrop:
                return artCrop
            case .borderCrop:
                return borderCrop
            case .large:
                return large
            case .png:
                return png
            case .normal:
                return normal
            case .small:
                return small
            }
        }
    }
}
