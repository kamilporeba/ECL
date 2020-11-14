import Foundation
import UIKit
import ECLModel

class ECLNavigationVC: UINavigationController {
    lazy var viewModel: ViewModel = ViewModel.createDefault()
    
    func navigateToDetails(of id:Int, with cityName: String, cityImage: UIImage) {
        viewModel.setDetailsViewModel(of: id)
        pushViewController(CityDetailsViewController(with: viewModel.cityDetailsViewModel, name: cityName, image: cityImage), animated: true)
    }
    
    func navigateToVisitors(with list:[String]) {
        present(VisitorsTableViewController(with: list), animated: true, completion: nil)
    }
}
