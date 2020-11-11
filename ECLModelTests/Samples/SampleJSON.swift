import Foundation

extension Decodable {
    static func jsonObject(of fileName: String) -> Any {
        let data = Data(fromResource: fileName, withExtension: "json")
        return try! JSONDecoder().decode(Self.self, from: data)
    }
}

extension Data {
    private class Token {}

    init(fromResource resource: String, withExtension extension: String) {
        let url = Bundle(for: Token.self).url(forResource: resource, withExtension: `extension`)!
        try! self.init(contentsOf: url)
    }
}
