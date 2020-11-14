extension Persisting {
    func setFavorite(favArray: [Int]) {
        set(value: favArray as AnyObject, for: "FAVORITE")
    }
    func retrieveFavorite()-> [Int]? {
        if let favorite = retrieve(for: "FAVORITE") as? [Int] {
            return favorite
        }
        return nil
    }
}
