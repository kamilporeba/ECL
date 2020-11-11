@testable import ECLModel

class ECLDataTaskCreatingMock: ECLTaskCreating {
    
    var mock_cityListDataTaskCompletion: ((@escaping (TaskReponse<CityList>) -> Void)-> Task)?
    func cityListDataTask(completionHandler: @escaping (TaskReponse<CityList>) -> Void) -> Task {
        return mock_cityListDataTaskCompletion?(completionHandler) ?? TaskMock()
    }
    
    var mock_visitorsDataTaskCompletion: ((@escaping (TaskReponse<Visitors>) -> Void)-> Task)?
    func visitorsDataTask(completionHandler: @escaping (TaskReponse<Visitors>) -> Void) -> Task {
        return mock_visitorsDataTaskCompletion?(completionHandler) ?? TaskMock()
    }
    
    var mock_rateDataTaskCompletion: ((@escaping (TaskReponse<Rate>) -> Void)-> Task)?
    func rateDataTask(completionHandler: @escaping (TaskReponse<Rate>) -> Void) -> Task {
        return mock_rateDataTaskCompletion?(completionHandler) ?? TaskMock()
    }

}
