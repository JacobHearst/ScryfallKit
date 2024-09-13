import ScryfallKit
import SwiftUI

struct SearchView: View {
  private let client = ScryfallClient()
  private let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)

  @State private var query = ""
  @State private var cards = [Card]()

  var body: some View {
    ScrollView {
      TextField("Search for Magic: the Gathering cards", text: $query)
        .textFieldStyle(.roundedBorder)
        .onSubmit(search)

      LazyVGrid(columns: columns) {
        ForEach(cards) { card in
          AsyncImage(url: card.getImageURL(type: .normal)) { image in
            image
              .resizable()
              .scaledToFit()
          } placeholder: {
            Text(card.name)
            ProgressView()
          }
        }
      }
    }
    .padding()
  }

  private func search() {
    Task {
      do {
        let results = try await client.searchCards(query: query)
        await MainActor.run {
          cards = results.data
        }
      } catch {
        print(error)
      }
    }
  }
}
