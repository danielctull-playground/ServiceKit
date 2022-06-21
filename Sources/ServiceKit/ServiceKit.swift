
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

    public subscript<Value>(keyPath: KeyPath<Self, Value>) -> Value {
        self[keyPath: keyPath]
    }

    public subscript<Value>(keyPath: WritableKeyPath<Self, Value>) -> Value {
        get { self[keyPath: keyPath] }
        set { self[keyPath: keyPath] = newValue }
    }

    public func replacing<Value>(_ keyPath: WritableKeyPath<Self, Value>, with value: Value) -> Self {
        var services = self
        services[keyPath] = value
        return services
    }
}

// MARK: - Compound Values

/// A ``ServiceCompoundKey`` is useful for building a service using existing
/// service values to prevent cyclic dependencies, a compound service _cannot_
/// depend on other compound services.
public protocol ServiceCompoundKey {
    associatedtype Value
    static func value(using values: Services.Values) -> Value
}

extension Services {

    public struct Values {

        fileprivate let services: Services

        public subscript<Key: ServiceKey>(key: Key.Type) -> Key.Value {
            services[key]
        }

        public subscript<Value>(keyPath: KeyPath<Services, Value>) -> Value {
            services[keyPath]
        }
    }

    public subscript<Key: ServiceCompoundKey>(key: Key.Type) -> Key.Value {
        get { values[ObjectIdentifier(key)] as? Key.Value ?? Key.value(using: Values(services: self)) }
        set { values[ObjectIdentifier(key)] = newValue }
    }
}
