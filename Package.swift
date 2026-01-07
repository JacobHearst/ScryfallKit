// swift-tools-version:6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "ScryfallKit",
  platforms: [.macOS(.v11), .iOS(.v14), .watchOS(.v11), .visionOS(.v26)],
  products: [
    .library(
      name: "ScryfallKit",
      targets: ["ScryfallKit"])
  ],
  dependencies: [
    .package(url: "https://github.com/apple/swift-docc-plugin", from: "1.0.0")
  ],
  targets: [
    .target(
      name: "ScryfallKit"
    ),
    .testTarget(
      name: "ScryfallKitTests",
      dependencies: ["ScryfallKit"]
    ),
  ]
)
