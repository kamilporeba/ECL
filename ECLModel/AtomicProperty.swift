@propertyWrapper
struct Atomic<Value> {
    private let queue = DispatchQueue(label: "com.poreba.kamil.atomicQueue")
    private var value: Value

    init(wrappedValue: Value) {
        self.value = wrappedValue
    }
    
    var wrappedValue: Value {
        get {
            return queue.sync { value }
        }
        set {
            queue.sync { value = newValue }
        }
    }
}
