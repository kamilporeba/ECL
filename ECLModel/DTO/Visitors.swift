struct Visitors: Decodable {
    let visitors: [Visitor]
}


struct Visitor: Decodable {
    let id: Int
    let name: String
}
