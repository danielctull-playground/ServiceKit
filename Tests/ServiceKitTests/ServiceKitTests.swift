
import ServiceKit
import XCTest

struct TestKey: ServiceKey {
    static let defaultValue = "Hello"
}

extension Services {

    var test: String {
        get { self[TestKey.self] }
        set { self[TestKey.self] = newValue }
    }
}

final class ServiceKitTests: XCTestCase {

    func testGetType() {
        let services = Services()
        XCTAssertEqual(services[TestKey.self], "Hello")
    }

    func testGetKeyPath() {
        let services = Services()
        XCTAssertEqual(services[\.test], "Hello")
    }

    func testSetType() {
        var services = Services()
        services[TestKey.self] = "World"
        XCTAssertEqual(services[TestKey.self], "World")
    }


    func testSetKeyPath() {
        var services = Services()
        services[\.test] = "World"
        XCTAssertEqual(services[\.test], "World")
    }

    func testReplacing() {
        let services = Services().replacing(\.test, with: "World")
        XCTAssertEqual(services[\.test], "World")
    }
}
