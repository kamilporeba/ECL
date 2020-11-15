import UIKit

class ErrorViewController: UIViewController {
    
    let errrorImageView: UIImageView = UIImageView()
    let errorDescritpionLabel: UILabel = UILabel()
    let refreshButton: UIButton = UIButton()
    
    var refreshAction: (()->())?
    
    private let margin: CGFloat = 15
    
    init(with errormessage: String, refreshAction: (()->())?) {
        self.refreshAction = refreshAction
        super.init(nibName: nil, bundle: nil)
        errorDescritpionLabel.text = errormessage
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewContrinats()
        customizeView()
        
    }
    
    func customizeView() {
        errrorImageView.contentMode = .scaleAspectFit
        errrorImageView.image = UIImage(named: "errorPlaceholder")
        errorDescritpionLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        errorDescritpionLabel.numberOfLines = 4
        errorDescritpionLabel.textAlignment = .center
        refreshButton.setTitleColor(.blue, for: .normal)
        refreshButton.setTitle("error_vc_refresh_button".localized, for: .normal)
        refreshButton.addTarget(self, action: #selector(refresh), for: .touchUpInside)
        view.backgroundColor = .white
    }
    @objc func refresh(sender: UIButton!) {
        refreshAction?()
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension ErrorViewController {
    func setupViewContrinats() {
        view.addSubview(errrorImageView)
        view.addSubview(errorDescritpionLabel)
        view.addSubview(refreshButton)
        
        setupImageConstraints()
        setupErrorMessageConstraints()
        setupRefreshButtonConstraints()
    }
    
    private func setupImageConstraints() {
        errrorImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            errrorImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            errrorImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: margin),
            errrorImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7)
        ])
    }
    
    private func setupErrorMessageConstraints() {
        errorDescritpionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            errorDescritpionLabel.topAnchor.constraint(equalTo: errrorImageView.bottomAnchor, constant: margin),
            errorDescritpionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: margin),
            errorDescritpionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -margin),
        ])
    }
    
    private func setupRefreshButtonConstraints() {
        refreshButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            refreshButton.topAnchor.constraint(equalTo: errorDescritpionLabel.bottomAnchor, constant: margin),
            refreshButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
