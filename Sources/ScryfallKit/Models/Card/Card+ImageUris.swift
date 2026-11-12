//
//  Card+ImageUris.swift
//

import Foundation

extension Card {
    /// Image URIs for each ``Card/ImageType``
    public struct ImageUris: Codable, Hashable, Sendable {
        /// A link to a small full card image.
        /// - Note: Designed for use as thumbnail or list icon.
        @available(*, deprecated, message: "Use thumb instead")
        public let small: String?
        /// A link to a medium-sized full card image
        @available(*, deprecated, message: "Use grid instead")
        public let normal: String?
        /// A link to a large full card image
        @available(*, deprecated, message: "Use display instead")
        public let large: String?
        /// A link to a rectangular crop of the card’s art only.
        /// - Note: Not guaranteed to be perfect for cards with outlier designs or strange frame arrangements
        @available(*, deprecated, message: "Use art instead")
        public let artCrop: String?
        /// A link to a full card image with the rounded corners and the majority of the border cropped off.
        /// - Note: Designed for dated contexts where rounded images can’t be used.
        @available(*, deprecated, message: "Use crop instead")
        public let borderCrop: String?

        /// A transparent, rounded full card PNG. This is the best image to use for videos or other high-quality content.
        public let png: String?
        /// A small thumbnail of the card image, replaces small
        public let thumb: String?
        /// A medium-sized full card image, replaces normal
        public let grid: String?
        /// A large full card image, replaces large
        public let display: String?
        /// A rectangular crop of the card’s art only. Replaces art_crop
        public let art: String?
        /// A full card image with the rounded corners and the majority of the border cropped off. Replaces border_crop
        public let crop: String?
        /// A medium-sized full card image, replaces normal
        public let jpeg: String?


        public init(
            small: String?,
            normal: String?,
            large: String?,
            png: String?,
            artCrop: String?,
            borderCrop: String?,
            thumb: String?,
            grid: String?,
            display: String?,
            art: String?,
            crop: String?,
            jpeg: String?,
        ) {
            self.small = small
            self.normal = normal
            self.large = large
            self.png = png
            self.artCrop = artCrop
            self.borderCrop = borderCrop
            self.thumb = thumb
            self.grid = grid
            self.display = display
            self.art = art
            self.crop = crop
            self.jpeg = jpeg
        }

        /// Get the URI for a specific image type
        /// - Parameter type: The image type to retrieve the URI for
        /// - Returns: The URI, if present
        public func uri(for type: Card.ImageType) -> String? {
            switch type {
            case .artCrop: return artCrop
            case .borderCrop: return borderCrop
            case .large: return large
            case .png: return png
            case .normal: return normal
            case .small: return small
            case .thumb: return thumb
            case .grid: return grid
            case .display: return display
            case .art: return art
            case .crop: return crop
            case .jpeg: return jpeg
            }
        }
    }
}
