// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "ServiceKit",
    platforms: [
        .iOS(.v14),
        .macOS(.v11),
        .tvOS(.v14),
        .watchOS(.v7),
    ],
    products: [
        .library(name: "ServiceKit", targets: ["ServiceKit"]),
    ],
    targets: [
        .target(name: "ServiceKit"),
        .testTarget(name: "ServiceKitTests", dependencies: ["ServiceKit"]),
    ]
)
