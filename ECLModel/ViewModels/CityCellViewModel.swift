public class CityCellViewModel {
    public let name: String
    let imageURL: String
    public var imageBase64: String?
    public let id: Int
    
    init(name: String, imageURL: String, id: Int) {
        self.name = name
        self.imageURL = imageURL
        self.id = id
        self.imageBase64 = ""
    }
    
    init(with city: City) {
        self.name = city.name
        self.imageURL = city.iconURL
        self.id = city.id
        self.imageBase64 = nil
    }
}
