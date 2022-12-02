//
//  File.swift
//  
//
//  Created by Jacob Hearst on 12/2/22.
//

import Foundation

extension MTGSet {
    /// A `Date` created from ``releasedAt``
    public var date: Date? {
        guard let releasedAt = releasedAt else { return nil }

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"

        return formatter.date(from: releasedAt)
    }
}
