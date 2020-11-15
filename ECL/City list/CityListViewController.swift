import ECLModel
import UIKit

class CityListViewController: UIViewController {
    private var cityListViewModel: CityListViewModel!
    @Atomic var cityList: [CityCellViewModel]
    
    let tableView = UITableView()
    lazy var favoriteFilter = UIBarButtonItem(title: "city_list_Favorites_filter_button".localized, style: .plain, target: self, action:  #selector(favoriteTapped))
    var isFavoritesPresented: Bool = false
    
    init(with viewModel: CityListViewModel) {
        self.cityListViewModel = viewModel
        self.cityList = [CityCellViewModel]()
        super.init(nibName: nil, bundle: nil)
        title = "City list"
        cityListViewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        registerCell()
        cityListViewModel.fetchList()
        cityListViewModel.delegate = self
        setupTableView()
        addFilterFavoriteButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        isFavoritesPresented ? (cityList = cityListViewModel.favorites) : (cityList = cityListViewModel.cityCell)
        tableView.reloadData()
    }
    
    private func addFilterFavoriteButton() {
        self.navigationController?.navigationBar.tintColor = .blue
        navigationItem.rightBarButtonItem = favoriteFilter
    }
    
    @objc func favoriteTapped(sender: AnyObject) {
        if isFavoritesPresented {
            favoriteFilter.title = "city_list_Favorites_filter_button".localized
            cityList = cityListViewModel.cityCell
            isFavoritesPresented = false
        } else {
            favoriteFilter.title = "city_list_all_filter_button".localized
            cityList = cityListViewModel.favorites
            isFavoritesPresented = true
        }
        tableView.reloadData()
    }
    
    private func registerCell() {
        tableView.register(CityTableViewCell.self, forCellReuseIdentifier: CityTableViewCell.cellIdentifier)
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 100
    }
}

extension CityListViewController: CityListViewModelDelegate {
    func didUpdateList(cityList: [CityCellViewModel]) {
        self.cityList = cityList
        tableView.reloadData()
        cityList.forEach{cityListViewModel.fetchImage(of: $0.id)}
    }
    
    func didFetchImage(for cityId: Int) {
        tableView.reloadData()
    }
    
    func didErrorOccured(message: String) {
        print(message)
    }
}

extension CityListViewController {
    func setupView(){
        view.addSubview(tableView)
        view.backgroundColor = .white
        setupTableViewConstraint()
    }
    
    func setupTableViewConstraint() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}
