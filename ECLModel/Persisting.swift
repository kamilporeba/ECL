protocol Persisting {
    func set(value: AnyObject, for key: String)
    func retrieve(for key: String) -> AnyObject?
}
