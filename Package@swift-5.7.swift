// swift-tools-version:5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "ScryfallKit",
  platforms: [.macOS(.v10_13), .iOS(.v12)],
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
      dependencies: ["ScryfallKit"]),
  ]
)
