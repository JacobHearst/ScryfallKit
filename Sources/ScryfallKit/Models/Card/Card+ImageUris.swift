//
//  Card+ImageUris.swift
//

import Foundation

extension Card {
  /// Image URIs for each ``Card/ImageType``
  public struct ImageUris: Codable, Hashable, Sendable {
    /// A link to a small full card image.
    /// - Note: Designed for use as thumbnail or list icon.
    public let small: String?
    /// A link to a medium-sized full card image
    public let normal: String?
    /// A link to a large full card image
    public let large: String?
    /// A link to a transparent, rounded full card PNG.
    /// - Note: This is the best image to use for videos or other high-quality content.
    public let png: String?
    /// A link to a rectangular crop of the card’s art only.
    /// - Note: Not guaranteed to be perfect for cards with outlier designs or strange frame arrangements
    public let artCrop: String?
    /// A link to a full card image with the rounded corners and the majority of the border cropped off.
    /// - Note: Designed for dated contexts where rounded images can’t be used.
    public let borderCrop: String?

    public init(
      small: String?, normal: String?, large: String?, png: String?, artCrop: String?,
      borderCrop: String?
    ) {
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
