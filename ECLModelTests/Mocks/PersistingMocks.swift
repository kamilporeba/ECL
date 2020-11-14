@testable import ECLModel

class PersistingMock: Persisting {
    var storage: [String: AnyObject] = [String: AnyObject] ()
    
    func set(value: AnyObject, for key: String) {
        storage[key] = value
    }
    
    func retrieve(for key: String) -> AnyObject? {
        return storage[key]
    }
    
    
}
