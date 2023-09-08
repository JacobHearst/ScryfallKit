# ScryfallKit
[![Build and test](https://github.com/JacobHearst/ScryfallKit/actions/workflows/build+test.yml/badge.svg)](https://github.com/JacobHearst/ScryfallKit/actions/workflows/build+test.yml) [![Swift Version Compatibility](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FJacobHearst%2FScryfallKit%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/JacobHearst/ScryfallKit) [![Platform Support](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FJacobHearst%2FScryfallKit%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/JacobHearst/ScryfallKit)

A Swift Package for accessing [Scryfall's REST API](https://scryfall.com/docs/api)

## Documentation
This library is largely a translation of Scryfall's REST API to a collection of Swift enums and structs. It is highly recommended that you read the [official Scryfall API docs](https://scryfall.com/docs/api) as the documentation in this project will not attempt to give in-depth explanations of how each of these endpoints work.

For the most up to date documentation, use the DocC pages published [here](https://jacobhearst.github.io/ScryfallKit/documentation/scryfallkit/)

To generate these pages locally, use this command from [Apple's Swift DocC plugin](https://github.com/apple/swift-docc-plugin#previewing-documentation)

`swift package --disable-sandbox preview-documentation --target ScryfallKit`

## Getting Started
Add ScryfallKit to your project either through the Xcode UI, or through the process below for Swift Packages
```swift
let package = Package(
    // ... Other Package.swift stuff goes here
    dependencies: [
        .package(url: "https://github.com/JacobHearst/ScryfallKit", from: "5.0.0"), // Add the library to your manifest
    ],
    targets: [
        .target(name: "MyPackage", dependencies: ["ScryfallKit"]), // Add it to your target's dependencies
    ]
)
```

## Example
```swift
import ScryfallKit

let client = ScryfallClient()

// Retrieve the Strixhaven Mystical Archive printing of Doom Blade
do {
    let doomBlade = try await client.getCardByName(exact: "Doom Blade", set: "STA")
    print(doomBlade.cmc)
} catch {
    print("Received error: \(error)")
}

// Or using a completion handler
client.getCardByName(exact: "Doom Blade", set: "STA") { result in
    switch result {
    case .success(let doomBlade):
        print(doomBlade.cmc)
    case .failure(let error):
        print("Received error: \(error)")
    }
}
```

## Network Logging
The ScryfallClient has a configurable level of network logging with two options: minimal and verbose. Enabling verbose logging will print the HTTP body of each request and response. Minimal logging will log that a request was made (and the URL it's made to) as well as that a response was received.

## Contributing
Contributions are always welcome, simply fork this repo, make and test your changes, and then open a pull request. I will try and review it within a reasonable amount of time.
