protocol CityListListener: AnyObject {
    func didUpdateCityList(with list: CityList)
    func didUpdateVisitors(with visitors: Visitors)
    func didUpdateRate(with rate: Rate)
    func didFetchAllDetails()
    func didErrorOccure(error: ModelError)
    func didFetchImage(base64Image: String, of cityId: Int)
}

extension CityListListener {
    func didUpdateCityList(with list: CityList){}
    func didUpdateVisitors(with visitors: Visitors){}
    func didUpdateRate(with rate: Rate){}
    func didFetchAllDetails(){}
    func didErrorOccure(error: ModelError){}
    func didFetchImage(base64Image: String, of cityId: Int){}
}

protocol CityListModelProtocol {
    func fetchCityList()
}

class CityListModel: CityListModelProtocol {
    
    private let dataTaskCreating: ECLTaskCreating
    private let imageFetcher: ImageFetchable = ImageFetcher()
    private let persisting: Persisting
    
    init(dataTaskCreating: ECLTaskCreating, persisting: Persisting) {
        self.dataTaskCreating = dataTaskCreating
        self.persisting = persisting
    }
    
    @Atomic private var cityList: CityList? {
        didSet {
            if let list = cityList {
                listeners.forEach {$0()?.didUpdateCityList(with: list)}
            }
        }
    }
    
    @Atomic private var visitors: Visitors? {
        didSet {
            if let visitors = visitors {
                listeners.forEach {$0()?.didUpdateVisitors(with: visitors)}
            }
        }
    }
    
    @Atomic private var rate: Rate? {
        didSet {
            if let rate = rate {
                listeners.forEach { $0()?.didUpdateRate(with: rate)}
            }
        }
    }
    
    @Atomic private var isFetchedDetails: Bool? {
        didSet {
            listeners.forEach { $0()?.didFetchAllDetails()}
        }
    }
    
    @Atomic private var error: ModelError? {
        didSet {
            if let modelError = error {
                 listeners.forEach { $0()?.didErrorOccure(error: modelError)}
            }
        }
    }
    
    public var favorites: [Int] {
        get {
            guard let favoritesArray = persisting.retrieveFavorite() else {
                return [Int]()
            }
            return favoritesArray
        }
    }
    
    private var listeners: [() -> CityListListener?] = []
    func addListener(listener: CityListListener) {
        listeners.append { [weak listener] in
            listener
        }
        if let list = cityList {
            listener.didUpdateCityList(with: list)
        }
    }
    
    func fetchCityList() {
        dataTaskCreating.cityListDataTask { (response) in
            switch response {
            case .success(let cityList):
                self.cityList = cityList
            default:
                self.error = ModelError(with: response)
            }
        }.resume()
    }
    
    private let fetchDetailsGroup = DispatchGroup()
    private lazy var fetchRateDWI = DispatchWorkItem {[weak self] in
        self?.fetchDetailsGroup.enter()
        self?.dataTaskCreating.rateDataTask { [weak self] (response) in
            self?.fetchDetailsGroup.leave()
            switch response {
            case .success(let rates):
                self?.rate = rates
                self?.isFetchedDetails = true
            default:
                self?.error = ModelError(with: response)
            }
        }.resume()
    }
    func fetchDetails(of cityId: Int) {
        fetchDetailsGroup.enter()
        
        dataTaskCreating.visitorsDataTask {[weak self] (response) in
            switch response {
            case .success(let visitors):
                self?.visitors = visitors
            default:
                self?.error = ModelError(with: response)
            }
            self?.fetchDetailsGroup.leave()
        }.resume()
        
        fetchDetailsGroup.notify(queue: DispatchQueue.global(qos: .default), work: fetchRateDWI)
    }

    func getImage(of cityId: Int) {
        if let imageStringURL = cityList?.europeCities.first(where: {$0.id == cityId})?.iconURL {
            imageFetcher.fetchImage(of: imageStringURL) {[weak self] (base64Image, error) in
                if let base64Image = base64Image {
                    self?.listeners.forEach { $0()?.didFetchImage(base64Image: base64Image, of: cityId)}
                }
            }
        }
    }
    
    func addToFavorite(cityId: Int) {
        if let favoriteArray = persisting.retrieveFavorite() {
            var newFavorite = favoriteArray
            newFavorite.append(cityId)
            persisting.setFavorite(favArray: newFavorite)
        } else {
            persisting.setFavorite(favArray: [cityId])
        }
    }
    
    func removeFromFavorite(cityId: Int) {
        if let favoriteArray = persisting.retrieveFavorite() {
            var newFavorite = favoriteArray
            newFavorite.removeAll(where: {$0 == cityId})
            persisting.setFavorite(favArray: newFavorite)
        } else {
            return
        }
    }
}
