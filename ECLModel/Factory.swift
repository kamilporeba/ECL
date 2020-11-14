import Foundation

public extension ViewModel {
    class func createDefault() -> ViewModel {
        let cityListModel = CityListModel(dataTaskCreating: URLSession.shared, persisting: UserDefaults.standard)
        let cityListViewModel = CityListViewModel(with: cityListModel)
        let cityDetailsViewModel = CityDetailsViewModel(with: cityListModel, of: -1)
        return ViewModel(with: cityListModel,
                         cityListViewModel: cityListViewModel,
                         cityDetailsViewModel: cityDetailsViewModel)
    }
}
