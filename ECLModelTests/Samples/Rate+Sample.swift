@testable import ECLModel

extension Rate {
    static func test_sampleRate() -> Rate {
        return try! JSONDecoder().decode(Rate.self, from: Data(fromResource: "Rate", withExtension: "json"))
    }
}

