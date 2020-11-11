import XCTest

extension XCTestCase {
    func expectation() -> XCTestExpectation {
        return expectation(description: "completion ...")
    }

    func waitForExpectations() {
        waitForExpectations(timeout: 0.2, handler: nil)
    }
}
