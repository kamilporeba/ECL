protocol ImageFetchable {
    func fetchImage(of urlString: String, completion: @escaping (_ base64Image: String?, _ error: Error?)->())
}

class ImageFetcher: ImageFetchable {
    private let cityImageCache = NSCache<NSString,NSString>()
    
    func fetchImage(of urlString: String, completion: @escaping (_ base64Image: String?, _ error: Error?)->()) {
        if let cachedImage = cityImageCache.object(forKey: urlString as NSString) {
            completion(cachedImage as String, nil)
        } else {
            if let url = URL(string: urlString) {
                URLSession.shared.dataTask(with: url) {[weak self] (data, response, error) in
                    if data != nil {
                        let base64Image = data!.base64EncodedString()
                        self?.cityImageCache.setObject(NSString(string: base64Image), forKey: NSString(string: urlString))
                        completion(base64Image, nil)
                    }
                    completion(nil,error)
                }
            }
        }
    }
}
