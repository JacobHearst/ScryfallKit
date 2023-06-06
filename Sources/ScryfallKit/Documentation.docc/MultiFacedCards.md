# Multi-Faced Cards

Dealing with cards that have multiple faces

@Metadata {
    @PageKind(sampleCode)
}

## Overview

Magic: the Gathering has a variety of card layouts that are considered "multi-face". These layouts are often identified by an accompanying game mechanic like Transform. Another, less obvious, example would be cards with a "split" layout such as [Armed // Dangerous](https://scryfall.com/card/dgm/122/armed-dangerous) or [Appeal // Authority](https://scryfall.com/card/hou/152/appeal-authority). As each card face is treated like a separate card, each face may have different values for core fields. Mana cost, card type, and power and toughness are some examples. Scryfall has written about this topic themselves [here](https://scryfall.com/docs/api/layouts#card-faces).

ScryfallKit includes some built in helper functions that make dealing with multi-faced cards easier. For example, ``ScryfallKit/Card/getImageURL(type:getSecondFace:)`` and ``ScryfallKit/Card/getImageURL(types:getSecondFace:)`` both have a `getSecondFace` parameter that does exactly what it sounds like: if set to `true`, it will return a url to the second face's art.

```swift
let client = ScryfallClient()

let thingInTheIce = try await client.getCardByName(exact: "Thing in the Ice")
if let imageURL = thingInTheIce.getImageURL(type: .normal, getSecondFace: true) {
    print(imageURL) // https://cards.scryfall.io/normal/back/3/5/359d1b13-6156-43b0-a9a7-6bfff36c1a91.jpg?1576384282
}
```

Similarly, ``ScryfallKit/Card/getAttributeForFace(keyPath:useSecondFace:)`` allows you to use key paths to get the field for either the front or the back face via the `useSecondFace` parameter

```swift
let client = ScryfallClient()

let thingInTheIce = try await client.getCardByName(exact: "Thing in the Ice")
print(try thingInTheIce.getAttributeForFace(keyPath: \.name, useSecondFace: true)) // Awoken Horror

let arclightPhoenix = try await client.getCardByName(exact: "Arclight Phoenix")
// Will throw because Arclight is a single-faced card
let cardBack = try arclightPhoenix.getAttributeForFace(keyPath: \.name, useSecondFace: true)
```
