import UIKit

class VisitorsTableViewController: UITableViewController {
    static let visitorCellIdentifier = "VisitorCell"
    
    var visitors: [String]
    
    init(with visitors: [String]) {
        self.visitors = visitors
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "VisitorCell")
    }
    
    
    
}

extension VisitorsTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return visitors.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: VisitorsTableViewController.visitorCellIdentifier)!
        cell.textLabel?.text = visitors[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}
