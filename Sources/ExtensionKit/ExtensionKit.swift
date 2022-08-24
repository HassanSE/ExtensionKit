import Foundation


public struct ExtensionKit {
    public private(set) var text = "Hello, World!"

    public init() {
    }
}

public extension Int {
    
    /// Convert an Int value to a comma formatted string. For example 1000 -> 1,000
    var commaFormatted: String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value: self))
    }
}
