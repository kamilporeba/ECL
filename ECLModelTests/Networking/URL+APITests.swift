@testable import ECLModel
import XCTest

class URL_APITests: XCTestCase {

    func testShouldIncludeBaseURL() {
        let url = URL(with: "/test/endpoint")
        XCTAssertEqual(url.absoluteString, "https://gist.githubusercontent.com/kamilporeba/test/endpoint")
    }

}
