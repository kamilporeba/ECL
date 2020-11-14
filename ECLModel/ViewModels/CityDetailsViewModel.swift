public protocol CityDetailsViewModelDelegate: AnyObject {
    func didErrorOccured(errorMessage: String)
    func didFetchDetails(visitors: [String], rate: Float)
}

class CityDetailsViewModel {
    weak var delegate: CityDetailsViewModelDelegate?
    let model: CityListModel
    
    var visitors: [String] = [String]()
    var rate: Float = 0.0
    var cityId: Int
    
    
    init(with model: CityListModel, of cityId: Int) {
        self.model = model
        self.cityId = cityId
        model.addListener(listener: self)
    }
    
    func fetchAllDetails() {
        model.fetchDetails(of: cityId)
    }
}

extension CityDetailsViewModel: CityListListener {
    func didUpdateVisitors(with visitors: Visitors) {
        self.visitors = visitors.visitors.compactMap {$0.name}
    }
    
    func didUpdateRate(with rate: Rate) {
        self.rate = rate.rating
    }
    
    func didFetchAllDetails() {
        delegate?.didFetchDetails(visitors: visitors, rate: rate)
    }
    
    func didErrorOccure(error: ModelError){
        delegate?.didErrorOccured(errorMessage: error.description)
    }
}
