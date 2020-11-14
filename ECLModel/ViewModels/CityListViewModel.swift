public protocol CityListViewModelDelegate: AnyObject {
    func didUpdateList(cityList: [CityCellViewModel])
    func didFetchImage(for cityId: Int)
    func didErrorOccured(message: String)
}

public class CityListViewModel  {
    public weak var delegate: CityListViewModelDelegate?
    let model: CityListModel!
    public var cityCell: [CityCellViewModel] = [CityCellViewModel]()
    
    init(with model: CityListModel) {
        self.model = model
        model.addListener(listener: self)
    }
    
    public var favorites: [CityCellViewModel] {
        let favorites = model.favorites
        return cityCell.filter {favorites.contains($0.id)}
    }
    
    public func fetchList() {
        model.fetchCityList()
    }
    
    public func fetchImage(of cityId: Int) {
        model.getImage(of: cityId)
    }
}

extension CityListViewModel: CityListListener {
    func didUpdateCityList(with list: CityList) {
        cityCell = list.europeCities.compactMap{CityCellViewModel(with: $0)}
        delegate?.didUpdateList(cityList: cityCell)
    }
    
    func didFetchImage(base64Image: String, of cityId: Int) {
        if let cellModel = cityCell.first(where: {$0.id == cityId}) {
            cellModel.imageBase64 = base64Image
        }
        delegate?.didFetchImage(for: cityId)
    }
    
    func didErrorOccure(error: ModelError) {
        delegate?.didErrorOccured(message: error.description)
    }
}
