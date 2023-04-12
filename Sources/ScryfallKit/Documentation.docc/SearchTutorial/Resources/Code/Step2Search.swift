import SwiftUI
import ScryfallKit

struct ContentView: View {
    private let client = ScryfallClient()
    @State private var query = ""
    @State private var cards = [Card]()

    var body: some View {
        ScrollView {
            TextField("Search for Magic: the Gathering cards", text: $query)
                // Makes our `TextField` easier to see
                .textFieldStyle(.roundedBorder)
                .onSubmit(search)

            // Creates a 2 column wide vertical grid
            LazyVGrid(columns: Array(repeating: .init(.flexible()), count: 2)) {
                ForEach(cards) { card in
                    AsyncImage(url: card.getImageURL(type: .normal)) { image in
                        // When the image loads, scale and display it
                        image
                            .resizable()
                            .scaledToFit()
                    } placeholder: {
                        // While the picture is loading, display the card name and a spinner
                        Text(card.name)
                        ProgressView()
                    }
                }
            }

            Spacer()
        }
        .padding()
    }

    private func search(query: String) {
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

