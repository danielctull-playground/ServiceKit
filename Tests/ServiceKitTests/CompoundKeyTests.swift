
import ServiceKit
import XCTest

struct Container: Equatable {
    let value: String
}

struct ContainerKey: ServiceCompoundKey {

    static func value(using values: Services.Values) -> Container {
        Container(value: values[StringKey.self])
    }
}

extension Services {

    var container: Container {
        get { self[ContainerKey.self] }
        set { self[ContainerKey.self] = newValue }
    }
}

final class CompoundKeyTests: XCTestCase {

    func testGet() {
        let services = Services()
        XCTAssertEqual(services[ContainerKey.self], Container(value: "Hello"))
        XCTAssertEqual(services[\.container], Container(value: "Hello"))
    }

    func testSet() {
        var services = Services()

        do {
            let container = Container(value: UUID().uuidString)
            services[ContainerKey.self] = container
            XCTAssertEqual(services[ContainerKey.self], container)
            XCTAssertEqual(services[\.container], container)
        }

        do {
            let container = Container(value: UUID().uuidString)
            services[\.container] = container
            XCTAssertEqual(services[ContainerKey.self], container)
            XCTAssertEqual(services[\.container], container)
        }
    }

    func testReplacing() {
        let container = Container(value: UUID().uuidString)
        let services = Services().replacing(\.container, with: container)
        XCTAssertEqual(services[ContainerKey.self], container)
        XCTAssertEqual(services[\.container], container)
    }

    /// Because compounds are created each time they are asked for, they change
    /// as their dependencies change.
    func testReplacingDependency() {
        let string = UUID().uuidString
        let services = Services().replacing(\.string, with: string)
        XCTAssertEqual(services[ContainerKey.self].value, string)
        XCTAssertEqual(services[\.container].value, string)
    }
}
