import XCTest
@testable import KSearchBar

final class KSearchBarTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(KSearchBar().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
