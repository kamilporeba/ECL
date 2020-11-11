struct CityList: Decodable {
    let europeCities: [City]
}

struct City: Decodable {
    let id: Int
    let name: String
    let iconURL: String
}
