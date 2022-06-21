
import ServiceKit
import XCTest

struct TestKey: ServiceKey {
    static let defaultValue = "Hello"
}

final class ServiceKitTests: XCTestCase {

    func testGetType() {
        let services = Services()
        XCTAssertEqual(services[TestKey.self], "Hello")
    }

    func testSetType() {
        var services = Services()
        services[TestKey.self] = "World"
        XCTAssertEqual(services[TestKey.self], "World")
    }
}
