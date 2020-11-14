extension UserDefaults: Persisting {
    func set(value: AnyObject, for key: String) {
        set(value, forKey: key)
    }
    
    func retrieve(for key: String) -> AnyObject? {
        return  object(forKey: key) as AnyObject?
    }
}
