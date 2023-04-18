#  ``ScryfallKit``

A simple Swift wrapper for the popular Magic: the Gathering API by Scryfall

> Warning: This library does not implement the 10 requests/second rate limiting requested by the Scryfall team. 
> 
> "We encourage you to cache the data you download from Scryfall or process it locally in your own database, at least for 24 hours. Scryfall provides our entire database compressed for download in daily bulk data files" ([Scryfall](https://scryfall.com/docs/api#rate-limits-and-good-citizenship)).

This library is largely a translation of Scryfall's REST API to a collection of Swift enums and structs. It is highly recommended that you read the [official Scryfall API docs](https://scryfall.com/docs/api) as the documentation in this project will not attempt to give in-depth explanations of how each of these endpoints work.

Some recommended starting points:
- [Lists and pagination](https://scryfall.com/docs/api/lists)
- [Errors](https://scryfall.com/docs/api/errors)
- [Card Imagery](https://scryfall.com/docs/api/images)
- [Layouts and Faces](https://scryfall.com/docs/api/layouts)

## Topics

### Fundamentals

- <doc:SearchTutorial>
- <doc:RetrievingCards>
- <doc:MultiFacedCards>
