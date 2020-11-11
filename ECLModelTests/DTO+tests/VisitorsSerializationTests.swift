import XCTest
@testable import ECLModel

class VisitorsSerializationTests: XCTestCase {
    private var response: Visitors!
    
    override func setUp() {
        response = try! JSONDecoder().decode(Visitors.self, from: Data(fromResource: "Visitors", withExtension: "json"))
    }
    
    override func tearDown() {
        response = nil
        super.tearDown()
    }
    
    func test_shouldReturnNotEmptyArray() {
        XCTAssertFalse(response.visitors.isEmpty)
    }
    
    func test_shouldSerializeVisitors() {
        let jhon = response.visitors.first
        XCTAssertNotNil(jhon)
        XCTAssertEqual(jhon?.id, 345)
        
    }
}
