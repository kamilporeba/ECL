protocol RateDataTaskCreating: RestDataTaskCreating {
    func rateDataTask(completionHandler: @escaping (TaskReponse<Rate>) -> Void) -> Task
}

extension RateDataTaskCreating {
    func rateDataTask(completionHandler: @escaping (TaskReponse<Rate>) -> Void) -> Task {
        let url = URL(with: "/9cf82983affe65cf1c03db3f8c2925bc/raw/d2f0774f464e09b7670328237d843890e71ff393/rating")
        let request = URLRequest(url: url)
        return dataTask(with: request, completionHandler: completionHandler)
    }
}

