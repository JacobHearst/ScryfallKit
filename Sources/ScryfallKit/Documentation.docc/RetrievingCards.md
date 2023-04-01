#  Retrieving Cards

How to retrieve one or more cards from Scryfall

## By Searching

ScryfallKit provides two ways to searching for cards:
- Using the ``ScryfallKit/CardFieldFilter`` enum
- Using a string that contains valid [Scryfall Syntax](https://scryfall.com/docs/syntax)

#### Using CardFieldFilter
```swift
let client = ScryfallClient()
let filters: [CardFieldFilter] = [
    CardFieldFilter.type("forest"),
    CardFieldFilter.type("creature")
]

let cards = try await client.searchCards(filters: filters)
print(cards.data[0].name) // Prints "Dryad Arbor"
```

#### Using Scryfall Syntax
```swift
let client = ScryfallClient()

let cards = try await client.searchCards(query: "t:creature t:forest")
print(cards.data[0].name) // Prints "Dryad Arbor"
```

## By Name
Scryfall's API supports retrieving a single card by both fuzzy and exact matching on the card name. It's recommended you read [Scryfall's documentation](https://scryfall.com/docs/api/cards/named) on this endpoint for better understanding of how name matching works and what errors you can expect.

#### Using an exact name
```swift
let client = ScryfallClient()
let narsetEnlightenedMaster = try await client.getCardByName(exact: "Narset, Enlightened Master")
print(narsetEnlightenedMaster.collectorNumber) // Prints "190"
```

#### Using a fuzzy name
```swift
let client = ScryfallClient()
let narsetEnlightenedMaster = try await client.getCardByName(fuzzy: "Narset, Master")
print(narsetEnlightenedMaster.collectorNumber) // Prints "190"
```

## By Identifier
There are a number of ways to identify an individual Magic: the Gathering card using the different card properties. Scryfall allows you to identify a card based on the following fields
- [Scryfall ID](Card/Identifier/scryfallID(id:))
- [MTGO ID](Card/Identifier/mtgoID(id:))
- [Multiverse ID](Card/Identifier/multiverseID(id:))
- [Arena ID](Card/Identifier/arenaID(id:))
- [TCGPlayer ID](Card/Identifier/tcgPlayerID(id:))
- [Cardmarket ID](Card/Identifier/cardMarketID(id:))
- [Set code, collector #, and language](Card/Identifier/setCodeCollectorNo(setCode:collectorNo:lang:))

You can use these identifiers to retrieve individual cards with ``ScryfallKit/ScryfallClient/getCard(identifier:completion:)`` or to retrieve up to 75 cards at once with ``ScryfallClient/getCardCollection(identifiers:completion:)``

#### Retrieving a single card
```swift
let client = ScryfallClient()

// Using the card's Scryfall ID
let flumphScryfallID: Card.Identifier = .scryfallID(id: "cdc86e78-8911-4a0d-ba3a-7802f8d991ef")
let flumph = try await client.getCard(identifier: flumphScryfallID)
print(flumph.setName) // Adventures in the Forgotten Realms

// Using the cards set code and collector number
let mysteryIdentifier: Card.Identifier = .setCodeCollectorNo(setCode: "mrd", collectorNo: "150")
let mysteryCard = try await client.getCard(identifier: mysteryIdentifier)
print(mysteryCard.name) // Chalice of the Void
```

#### Retrieving a collection of cards
```swift
let client = ScryfallClient()
let identifiers: [Card.CollectionIdentifier] = [
    .scryfallID(id: "b2288f7b-05b1-4a6c-8d02-42ffcadc6f0b"),
    .name("Lotus Field"),
    .collectorNoAndSet(collectorNo: "12", set: "dgm")
]

let cards = try await client.getCardCollection(identifiers: identifiers)
let names = cards.data.map { $0.name }
print(names) // ["Pore Over the Pages", "Lotus Field", "Hidden Strings"]
```

## See Also
- ``ScryfallKit/ScryfallClient/searchCards(filters:unique:order:sortDirection:includeExtras:includeMultilingual:includeVariations:page:completion:)``
- ``ScryfallKit/ScryfallClient/searchCards(query:unique:order:sortDirection:includeExtras:includeMultilingual:includeVariations:page:completion:)``
- ``ScryfallKit/ScryfallClient/getCardByName(fuzzy:set:completion:)`` 
- ``ScryfallKit/ScryfallClient/getCardByName(exact:set:completion:)``
- ``ScryfallKit/ScryfallClient/getRandomCard(query:completion:)``
- ``ScryfallKit/ScryfallClient/getCard(identifier:completion:)``
- ``ScryfallKit/ScryfallClient/getCardCollection(identifiers:completion:)``
