import ScryfallKit
import SwiftUI

struct SearchView: View {
  private let client = ScryfallClient()
  private let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)

  @State private var loading = false
  @State private var query = ""
  @State private var cards = [Card]()
  @State private var error: String?
  @State private var showError = false

  var body: some View {
    ScrollView {
      TextField("Search for Magic: the Gathering cards", text: $query)
        .textFieldStyle(.roundedBorder)
        .onSubmit(search)

      if loading {
        ProgressView()
      } else {
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
    }
    .padding()
    .alert("Error", isPresented: $showError, presenting: error, actions: { _ in }) { error in
      Text(error)
    }
  }

  private func search() {
    loading = true
    error = nil
    showError = false

    Task {
      do {
        let results = try await client.searchCards(query: query)
        await MainActor.run {
          cards = results.data
        }
      } catch {
        self.error = error.localizedDescription
        self.showError = true
      }

      loading = false
    }
  }
}
