
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
        XCTAssertEqual(services[\.test], string)
    }

    func testReplacing() {
        let string = UUID().uuidString
        let services = Services().replacing(\.test, with: string)
        XCTAssertEqual(services[\.test], string)
    }
}

struct TestKey: ServiceKey {
    static let defaultValue = "Hello"
}

extension Services {

    var test: String {
        get { self[TestKey.self] }
        set { self[TestKey.self] = newValue }
    }
}
