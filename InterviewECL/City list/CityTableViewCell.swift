import UIKit
import ECLModel

class CityTableViewCell: UITableViewCell {
    static let cellIdentifier = "CityTableViewCell"
    
    let cityImage: UIImageView = UIImageView()
    var cityName: UILabel = UILabel()
    var heartLabel: UILabel = UILabel()

    override func awakeFromNib() {
        super.awakeFromNib()
        
        cityName.font = UIFont.preferredFont(forTextStyle: .title1)
        cityImage.contentMode = .scaleAspectFit
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let horizontalMargin: CGFloat = 20
        let verticalMargin: CGFloat = 10
        
        addSubview(cityName)
        addSubview(cityImage)
        addSubview(heartLabel)
        
        cityImage.translatesAutoresizingMaskIntoConstraints = false
        cityName.translatesAutoresizingMaskIntoConstraints = false
        heartLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cityImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: horizontalMargin),
            cityImage.topAnchor.constraint(equalTo: topAnchor, constant: verticalMargin),
            cityImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: verticalMargin),
            cityImage.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.45)
        ])
        
        NSLayoutConstraint.activate([
            cityName.leadingAnchor.constraint(equalTo: cityImage.trailingAnchor, constant: 5),
            cityName.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -horizontalMargin),
            cityName.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            heartLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            heartLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5)
        ])
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func fill(with viewModel: CityCellViewModel) {
        cityName.text = viewModel.name
        if let imageBase64 = viewModel.imageBase64 {
            self.cityImage.image = UIImage(with: imageBase64)
        }
    }
}
