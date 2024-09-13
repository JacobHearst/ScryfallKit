import ScryfallKit
import SwiftUI

struct SearchView: View {
  private let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)

  @State private var query = ""
  @State private var cards = [Card]()

  var body: some View {
    ScrollView {
      TextField("Search for Magic: the Gathering cards", text: $query)
        .textFieldStyle(.roundedBorder)

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
}
