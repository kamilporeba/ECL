@propertyWrapper
public struct Atomic<Value> {
    private let queue = DispatchQueue(label: "com.poreba.kamil.atomicQueue")
    private var value: Value

    public init(wrappedValue: Value) {
        self.value = wrappedValue
    }
    
    public var wrappedValue: Value {
        get {
            return queue.sync { value }
        }
        set {
            queue.sync { value = newValue }
        }
    }
}
