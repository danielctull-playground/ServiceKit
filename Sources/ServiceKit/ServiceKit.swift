
public protocol ServiceKey {
    associatedtype Value
    static var defaultValue: Value { get }
}

public struct Services {

    public init() {}

    private var values: [ObjectIdentifier: Any] = [:]

    public subscript<Key: ServiceKey>(key: Key.Type) -> Key.Value {
        get { values[ObjectIdentifier(key)] as? Key.Value ?? Key.defaultValue }
        set { values[ObjectIdentifier(key)] = newValue }
    }
}
