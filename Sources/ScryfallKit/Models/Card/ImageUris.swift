//
//  ImageUris.swift
//  
//
//  Created by Jacob Hearst on 7/15/22.
//

import Foundation

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
