
import ServiceKit
import XCTest

final class ServiceKitTests: XCTestCase {

    func testGetType() {
        let services = Services()
        XCTAssertEqual(services[TestKey.self], "Hello")
    }

    func testGetKeyPath() {
        let services = Services()
        XCTAssertEqual(services[\.test], "Hello")
    }

    func testGetTypeCompound() {
        let services = Services()
        XCTAssertEqual(services[ContainerKey.self], Container(value: "Hello"))
    }

    func testGetKeyPathCompound() {
        let services = Services()
        XCTAssertEqual(services[\.container], Container(value: "Hello"))
    }

    func testSetType() {
        let string = UUID().uuidString
        var services = Services()
        services[TestKey.self] = string
        XCTAssertEqual(services[TestKey.self], string)
    }

    func testSetKeyPath() {
        let string = UUID().uuidString
        var services = Services()
        services[\.test] = string
        XCTAssertEqual(services[TestKey.self], string)
    }

    func testSetTypeCompound() {
        let container = Container(value: UUID().uuidString)
        var services = Services()
        services[ContainerKey.self] = container
        XCTAssertEqual(services[ContainerKey.self], container)
    }

    func testSetKeyPathCompound() {
        let container = Container(value: UUID().uuidString)
        var services = Services()
        services[\.container] = container
        XCTAssertEqual(services[ContainerKey.self], container)
    }

    func testReplacing() {
        let string = UUID().uuidString
        let services = Services().replacing(\.test, with: string)
        XCTAssertEqual(services[\.test], string)
    }

    func testReplacingCompound() {
        let container = Container(value: UUID().uuidString)
        let services = Services().replacing(\.container, with: container)
        XCTAssertEqual(services[\.container], container)
    }
}

struct TestKey: ServiceKey {
    static let defaultValue = "Hello"
}

struct Container: Equatable {
    let value: String
}

struct ContainerKey: ServiceCompound {

    static func value(using values: Services.Values) -> Container {
        Container(value: values[\.test])
    }
}

extension Services {

    var test: String {
        get { self[TestKey.self] }
        set { self[TestKey.self] = newValue }
    }

    var container: Container {
        get { self[ContainerKey.self] }
        set { self[ContainerKey.self] = newValue }
    }
}
