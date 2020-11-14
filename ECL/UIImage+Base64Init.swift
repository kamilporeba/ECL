import UIKit

extension UIImage {
    convenience init?(with base64String: String?) {
        if let imageBase64 = base64String,
            let imageData = Data(base64Encoded: imageBase64)
        {
            self.init(data: imageData)
        } else {
            return nil
        }
        
    }
}
