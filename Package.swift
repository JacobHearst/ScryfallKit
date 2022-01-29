// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ScryfallKit",
    platforms: [.macOS(.v10_10), .iOS(.v9)],
    products: [
        .library(
            name: "ScryfallKit",
            targets: ["ScryfallKit"]),
    ],
    targets: [
        .target(
            name: "ScryfallKit",
            dependencies: []),
        .testTarget(
            name: "ScryfallKitTests",
            dependencies: ["ScryfallKit"]),
    ]
)
