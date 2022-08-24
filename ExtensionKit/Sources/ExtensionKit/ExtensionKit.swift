import Foundation


public struct ExtensionKit {
    public private(set) var text = "Hello, World!"

    public init() {
    }
}

public extension Int {
    var commaFormatted: String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value: self))
    }
}
