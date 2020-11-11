extension URL {
    static let baseURL = "https://gist.githubusercontent.com/kamilporeba"

    init(with endpoint: String) {
        self.init(string: URL.baseURL + endpoint)!
    }
}
