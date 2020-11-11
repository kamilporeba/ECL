@testable import ECLModel

extension Visitors {
    static func test_sampleVisitors() -> Visitors {
        return try! JSONDecoder().decode(Visitors.self, from: Data(fromResource: "Visitors", withExtension: "json"))
    }
}
