// swift-tools-version:6.2

import CompilerPluginSupport
import PackageDescription

let package = Package(
    name: "ScryfallKit",
    platforms: [.macOS(.v11), .iOS(.v14), .watchOS(.v11), .visionOS(.v26), .tvOS(.v14)],
    products: [.library(name: "ScryfallKit", targets: ["ScryfallKit"])],
    targets: [
        .target(name: "ScryfallKit", ),
        .testTarget(name: "ScryfallKitTests", dependencies: ["ScryfallKit"]),
    ]
)
