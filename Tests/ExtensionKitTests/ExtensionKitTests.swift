import XCTest
@testable import ExtensionKit

final class ExtensionKitTests: XCTestCase {
    
    func test_commaFormatting() {
        let value = 1000
        XCTAssertEqual(value.commaFormatted, "1,000")
    }
}
