import XCTest
@testable import ECLModel

class CityListSerializationTests: XCTestCase {
    private var response: CityList!
    
    override func setUp() {
        response = try! JSONDecoder().decode(CityList.self, from: Data(fromResource: "CityList", withExtension: "json"))
    }
    
    override func tearDown() {
        response = nil
        super.tearDown()
    }
    
    func test_shouldReturnNotEmptyArray() {
        XCTAssertFalse(response.europeCities.isEmpty)
    }
    
    func test_shouldSerializeCity() {
        let warsawCity = response.europeCities.first
        XCTAssertNotNil(warsawCity)
        XCTAssertEqual(warsawCity?.id, 1)
        XCTAssertEqual(warsawCity?.name, "Warsaw")
        XCTAssertEqual(warsawCity?.iconURL, "https://cdn.pixabay.com/photo/2018/02/04/23/33/mati-3131158_1280.jpg")
        
    }
}
