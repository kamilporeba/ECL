struct ModelError {
    let description: String
    
    init(with description: String) {
        self.description = description
    }
    
    init?<T>(with response: TaskReponse<T>) {
        switch response {
        case .serializationError:
            self.init(with: "Serialization error")
        case let .apiError(stausCode):
            self.init(with: "Problem with remote service status code: \(stausCode)")
        case let .networkError(error):
            self.init(with: error.localizedDescription)
        default:
            self.init(with: "Unknown error")
        }
    }
    
}
