
import ServiceKit
import XCTest

struct StringKey: ServiceKey {
    static let defaultValue = "Hello"
}

extension Services {

    var string: String {
        get { self[StringKey.self] }
        set { self[StringKey.self] = newValue }
    }

    // Required because there are two subscript methods - One taking KeyPath and
    // one taking WritableKeyPath. This tests the former readonly variant.
    var readonlyString: String {
        self[StringKey.self]
    }
}

final class ServiceKeyTests: XCTestCase {

    func testGet() {
        let services = Services()
        XCTAssertEqual(services[StringKey.self], "Hello")
        XCTAssertEqual(services[\.string], "Hello")
        XCTAssertEqual(services[\.readonlyString], "Hello")
    }

    func testSet() {
        var services = Services()

        do {
            let string = UUID().uuidString
            services[StringKey.self] = string
            XCTAssertEqual(services[StringKey.self], string)
            XCTAssertEqual(services[\.string], string)
            XCTAssertEqual(services[\.readonlyString], string)
        }

        do {
            let string = UUID().uuidString
            services[\.string] = string
            XCTAssertEqual(services[StringKey.self], string)
            XCTAssertEqual(services[\.string], string)
            XCTAssertEqual(services[\.readonlyString], string)
        }
    }

    func testReplacing() {
        let string = UUID().uuidString
        let services = Services().replacing(\.string, with: string)
        XCTAssertEqual(services[StringKey.self], string)
        XCTAssertEqual(services[\.string], string)
        XCTAssertEqual(services[\.readonlyString], string)
    }
}
