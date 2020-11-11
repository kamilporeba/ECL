protocol VisitorsTaskCreating: RestDataTaskCreating {
    func visitorsDataTask(completionHandler: @escaping (TaskReponse<Visitors>) -> Void) -> Task
}

extension VisitorsTaskCreating {
    func visitorsDataTask(completionHandler: @escaping (TaskReponse<Visitors>) -> Void) -> Task {
        let url = URL(with: "/9be4bf6538b9a19964917ad03dda60a7/raw/165b91c18527d68aaece99f9c9b70ebe0a9d3083/visitors_list")
        let request = URLRequest(url: url)
        return dataTask(with: request, completionHandler: completionHandler)
    }
}
