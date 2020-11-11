protocol CityListTaskCreating: RestDataTaskCreating {
    func cityListDataTask(completionHandler: @escaping (TaskReponse<CityList>) -> Void) -> Task
}

extension CityListTaskCreating {
    func cityListDataTask(completionHandler: @escaping (TaskReponse<CityList>) -> Void) -> Task {
        let url = URL(with: "/a90be3ac140e5523999de05beae29d41/raw/db5dc20668b5c7ccd80986be8b3674d6dbcdb30b/Europe_cities")
        let request = URLRequest(url: url)
        return dataTask(with: request, completionHandler: completionHandler)
    }
}
