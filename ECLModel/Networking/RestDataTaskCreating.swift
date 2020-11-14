enum TaskReponse<T: Decodable> {
    case success(T)
    case serializationError(Error?)
    case apiError(Int)
    case networkError(Error)
    case unknownError
}

protocol Task: AnyObject {
    func resume()
}

protocol RestDataTaskCreating {
    func dataTask<T: Decodable>(with request: URLRequest, completionHandler: @escaping (TaskReponse<T>) -> Void) -> URLSessionDataTask
}

extension RestDataTaskCreating {
    func dataTask<T: Decodable>(with request: URLRequest, completionHandler: @escaping (TaskReponse<T>) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request.url!) { (responseData, response, error) in
            if error != nil  {
                DispatchQueue.main.async {
                    completionHandler(.networkError(error!))
                }
                return
            }
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode > 200 {
                DispatchQueue.main.async {
                    completionHandler(.apiError(httpResponse.statusCode))
                }
                return
            }
            if let data = responseData {
                do {
                    let mappedObject = try JSONDecoder().decode(T.self, from: data)
                    DispatchQueue.main.async {
                        completionHandler(.success(mappedObject))
                    }
                } catch {
                    DispatchQueue.main.async {
                        completionHandler(.serializationError(error))
                    }
                }
                return
            }
            DispatchQueue.main.async {
                completionHandler(.unknownError)
            }
            
        }
        
    }
}
