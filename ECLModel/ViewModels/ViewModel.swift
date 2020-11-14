import Foundation

public class ViewModel {
    private let cityListModel: CityListModel!
    
    public let cityListViewModel: CityListViewModel!
    public var cityDetailsViewModel: CityDetailsViewModel!
    
    init(with cityListModel: CityListModel,
         cityListViewModel: CityListViewModel,
         cityDetailsViewModel: CityDetailsViewModel) {
        self.cityListModel = cityListModel
        self.cityListViewModel = cityListViewModel
        self.cityDetailsViewModel = cityDetailsViewModel
    }
    
    public func setDetailsViewModel(of cityId: Int) {
        self.cityDetailsViewModel = CityDetailsViewModel(with: cityListModel, of: cityId)
    }
}
