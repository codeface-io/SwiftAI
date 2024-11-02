// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftAI",
    platforms: [
        .macOS(.v14), .iOS(.v17)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "SwiftAI",
            targets: ["SwiftAI"]),
        .executable(
            name: "SwiftAIExample",
            targets: ["SwiftAIExample"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/flowtoolz/FoundationToolz.git", exact: "0.5.3"),
//        .package(path: "../FoundationToolz"),
        .package(url: "https://github.com/flowtoolz/SwiftyToolz.git", exact: "0.5.2"),
//        .package(path: "../SwiftyToolz"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "SwiftAI",
            dependencies: [
                "FoundationToolz",
                "SwiftyToolz"
            ]
        ),
        .executableTarget(
            name: "SwiftAIExample",
            dependencies: [
                "SwiftAI",
                "FoundationToolz",
                "SwiftyToolz"
            ]
        ),
        .testTarget(
            name: "SwiftAITests",
            dependencies: ["SwiftAI"]
        ),
    ]
)
