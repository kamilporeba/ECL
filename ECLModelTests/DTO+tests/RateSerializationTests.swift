import XCTest
@testable import ECLModel

class RateSerializationTests: XCTestCase {
    private var response: Rate!
    
    override func setUp() {
        response = try! JSONDecoder().decode(Rate.self, from: Data(fromResource: "Rate", withExtension: "json"))
    }
    
    override func tearDown() {
        response = nil
        super.tearDown()
    }
    
    func test_shouldSerializeRate() {
        XCTAssertEqual(response?.rating, 4.67)
        
    }
}
