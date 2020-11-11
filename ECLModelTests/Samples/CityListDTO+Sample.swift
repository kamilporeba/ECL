@testable import ECLModel

extension CityList {
    static func test_sampleCityList() -> CityList {
        return try! JSONDecoder().decode(CityList.self, from: Data(fromResource: "CityList", withExtension: "json"))
    }
}
