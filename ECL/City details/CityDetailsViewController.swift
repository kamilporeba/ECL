import ECLModel
import UIKit

class CityDetailsViewController: UIViewController {
    private var cityDetailsViewModel: CityDetailsViewModel!
    
    let cityimageView = UIImageView()
    let cityNameLabel = UILabel()
    let visitorsNumber = UILabel()
    let rateLabel = UILabel()
    let visitorsButton = UIButton()
    
    private let cityImage: UIImage
    private let cityName: String
    private var visitorList: [String] = [String]()
    lazy var addToFav = UIBarButtonItem(title: cityDetailsViewModel.isFavorite ? "details_vc_remove_from_fav".localized : "details_vc_add_to_fav".localized, style: .plain, target: self, action:  #selector(favoriteTapped))
    
    init(with viewModel: CityDetailsViewModel, name: String, image: UIImage) {
        self.cityDetailsViewModel = viewModel
        self.cityImage = image
        self.cityName = name
        super.init(nibName: nil, bundle: nil)
        title = cityName
        cityDetailsViewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewConstrints()
        cityDetailsViewModel.fetchAllDetails()
        customizeViews()
        fillData()
        addFilterFavoriteButton()
    }
    
    private func addFilterFavoriteButton() {
        self.navigationController?.navigationBar.tintColor = .blue
        navigationItem.rightBarButtonItem = addToFav
    }
    
    func fillData() {
        cityimageView.image = cityImage
        cityNameLabel.text = cityName
    }
    
    func customizeViews() {
        cityNameLabel.font = UIFont.preferredFont(forTextStyle: .title2)
        cityNameLabel.textAlignment = .center
        visitorsNumber.font = UIFont.preferredFont(forTextStyle: .body)
        rateLabel.font = UIFont.preferredFont(forTextStyle: .body)
        cityimageView.contentMode = .scaleAspectFit
        visitorsButton.setTitleColor(.blue, for: .normal)
        visitorsButton.setTitle("details_see_visitors_button_title".localized, for: .normal)
        visitorsButton.addTarget(self, action: #selector(visitors), for: .touchUpInside)
        
    }
    
    @objc func visitors(sender: UIButton!) {
        if let navVC = navigationController as? ECLNavigationVC {
            navVC.navigateToVisitors(with: visitorList)
        }
    }
    
    @objc func favoriteTapped(sender: AnyObject) {
        if cityDetailsViewModel.isFavorite  {
            addToFav.title = "details_vc_add_to_fav".localized
            cityDetailsViewModel.removeFromFavorite()
        } else {
            addToFav.title = "details_vc_remove_from_fav".localized
            cityDetailsViewModel.addToFavorite()
        }
    }
}

extension CityDetailsViewController: CityDetailsViewModelDelegate {
    func didErrorOccured(errorMessage: String) {
        if let navVC = navigationController as? ECLNavigationVC {
            navVC.navigateToError(with: errorMessage, refreshAction: { [weak self] in
                self?.cityDetailsViewModel.fetchAllDetails()
            })
        }
    }
    
    func didFetchDetails(visitors: [String], rate: Float) {
        rateLabel.text = "\("details_visitors_rating".localized) \(rate)"
        visitorsNumber.text = "\("datails_visitors_countTitle".localized) \(visitors.count)"
        visitorList = visitors
    }
}

extension CityDetailsViewController {
    func setupViewConstrints() {
        view.addSubview(cityimageView)
        view.addSubview(cityNameLabel)
        view.addSubview(visitorsNumber)
        view.addSubview(rateLabel)
        view.addSubview(visitorsButton)
        
        setupCityImage()
        setupCityName()
        setupVisitors()
        setupRate()
        setupVisitorsButton()
        view.backgroundColor = .white
    }
    
    private func setupCityImage() {
        cityimageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cityimageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            cityimageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            cityimageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            cityimageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3)
        ])
    }
    private func setupCityName() {
        let margin: CGFloat = 15
        cityNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cityNameLabel.topAnchor.constraint(equalTo: cityimageView.bottomAnchor),
            cityNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: margin),
            cityNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -margin),
        ])
    }
    private func setupVisitors() {
        let margin: CGFloat = 15
        visitorsNumber.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            visitorsNumber.topAnchor.constraint(equalTo: cityNameLabel.bottomAnchor),
            visitorsNumber.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: margin),
        ])
    }
    private func setupRate() {
        let margin: CGFloat = 15
        rateLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            rateLabel.topAnchor.constraint(equalTo: cityNameLabel.bottomAnchor),
            rateLabel.leadingAnchor.constraint(equalTo: visitorsNumber.trailingAnchor, constant: margin),
            rateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -margin),
        ])
    }
    private func setupVisitorsButton() {
        visitorsButton.translatesAutoresizingMaskIntoConstraints = false
        let margin: CGFloat = 15
        NSLayoutConstraint.activate([
            visitorsButton.topAnchor.constraint(equalTo: visitorsNumber.bottomAnchor, constant: margin),
            visitorsButton.leadingAnchor.constraint(equalTo: visitorsNumber.leadingAnchor)
        ])
    }
}
