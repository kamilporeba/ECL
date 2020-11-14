import UIKit
extension CityListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
          return 1
      }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CityTableViewCell.cellIdentifier) as! CityTableViewCell
        cell.fill(with: cityList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let city = self.cityList[indexPath.row]
        if let navController = navigationController as? ECLNavigationVC {
            navController.navigateToDetails(of: city.id, with: city.name, cityImage: UIImage(with: city.imageBase64) ?? UIImage(named: "cityPlaceholder")!)
        }
    }
}
