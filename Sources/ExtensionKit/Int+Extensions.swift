//
//  Int+Extensions.swift
//  Created by Muhammad Hassan on 25/08/2022.
//

import Foundation

public extension Int {
    
    /// Convert an Int value to a comma formatted string. For example 1000 -> 1,000
    var commaFormatted: String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value: self))
    }
}
