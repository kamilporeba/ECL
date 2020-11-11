@testable import ECLModel

class CityListModelListenerMock: CityListListener {
    
    var mock_didUpdateCityListCompletion: ((_ list: CityList)->())?
    func didUpdateCityList(with list: CityList) {
        mock_didUpdateCityListCompletion?(list)
    }
    
    var mock_didUpdateVisitorsCompletion: ((_ visitor: Visitors)->())?
    func didUpdateVisitors(with visitors: Visitors) {
        mock_didUpdateVisitorsCompletion?(visitors)
    }
    
    var mock_didUpdateRateCompletion: ((_ rate: Rate)->())?
    func didUpdateRate(with rate: Rate) {
        mock_didUpdateRateCompletion?(rate)
    }
    
    var mock_didFetchAllDetails: (()->())?
    func didFetchAllDetails() {
        mock_didFetchAllDetails?()
    }
    
    var mock_didErrorOccuredCompletion: ((_ error: ModelError)->())?
    func didErrorOccure(error: ModelError) {
        mock_didErrorOccuredCompletion?(error)
    }
    
    var mock_didFetchImage: ((_ base64Image: String, _ cityId: Int)->())?
    func didFetchImage(base64Image: String, of cityId: Int) {
        mock_didFetchImage?(base64Image,cityId)
    }
}
