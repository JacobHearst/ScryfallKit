# ScryfallKit
[![Build and test](https://github.com/JacobHearst/ScryfallKit/actions/workflows/build+test.yml/badge.svg)](https://github.com/JacobHearst/ScryfallKit/actions/workflows/build+test.yml)

A Swift Package for accessing [Scryfall's REST API](https://scryfall.com/docs/api)

## Getting Started
Add ScryfallKit to your project either through the Xcode UI, or through the process below for Swift Packages

    let package = Package(
        // ... Other Package.swift stuff goes here
        dependencies: [
            .package(url: "https://github.com/JacobHearst/ScryfallKit", from: "3.0.0"), // Add the library to your manifest
        ],
        targets: [
            .target(name: "MyPackage", dependencies: ["ScryfallKit"]), // Add it to your target's dependencies
        ]
    )
    
## Example

    import ScryfallKit
    
    let client = ScryfallClient()

    // Retrieve the Strixhaven Mystical Archive printing of Doom Blade
    client.getCardByName(exact: "Doom Blade", set: "STA") { result in
        switch result {
        case .success(let doomBlade):
            print(doomBlade.cmc)
        case .failure(let error):
            print("Received error: \(error)")
        }
    }
    
    // Or using async
    do {
        let doomBlade = try await client.getCardByName(exact: "Doom Blade", set: "STA")
        print(doomBlade.cmc)
    } catch {
        print("Received error: \(error)")
    }
    
## Network Logging
The ScryfallClient has a configurable level of network logging with two options: minimal and verbose. Enabling verbose logging will print the HTTP body of each request and response. Minimal logging will log that a request was made (and the URL it's made to) as well as that a response was received.

## Contributing
Contributions are always welcome, simply fork this repo, make and test your changes, and then open a pull request. I will try and review it within a reasonable amount of time.
