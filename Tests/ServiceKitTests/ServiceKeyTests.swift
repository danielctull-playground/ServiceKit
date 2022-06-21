
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
}

final class ServiceKeyTests: XCTestCase {

    func testGet() {
        let services = Services()
        XCTAssertEqual(services[StringKey.self], "Hello")
        XCTAssertEqual(services[\.string], "Hello")
    }

    func testSet() {
        var services = Services()

        do {
            let string = UUID().uuidString
            services[StringKey.self] = string
            XCTAssertEqual(services[StringKey.self], string)
            XCTAssertEqual(services[\.string], string)
        }

        do {
            let string = UUID().uuidString
            services[\.string] = string
            XCTAssertEqual(services[StringKey.self], string)
            XCTAssertEqual(services[\.string], string)
        }
    }

    func testReplacing() {
        let string = UUID().uuidString
        let services = Services().replacing(\.string, with: string)
        XCTAssertEqual(services[StringKey.self], string)
        XCTAssertEqual(services[\.string], string)
    }
}
