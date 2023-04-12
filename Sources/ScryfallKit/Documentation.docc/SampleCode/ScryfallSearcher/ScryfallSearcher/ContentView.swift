//
//  ContentView.swift
//  ScryfallSearcher
//

import SwiftUI
import ScryfallKit

struct ContentView: View {
    private let client = ScryfallClient()
    @State private var query = ""
    @State private var cards = [Card]()
    @State private var error: String?
    @State private var showError = false

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
                        // When the image loads, scale and display the image
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
        .alert("Error", isPresented: $showError, presenting: error, actions: { _ in }) { error in
            Text(error)
        }
    }

    private func search() {
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
                showError = true
            }
        }
    }
}


//struct ContentView: View {
//    private let client = ScryfallClient()
//    private let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
//
//    @State private var loading = false
//    @State private var query = ""
//    @State private var cards = [Card]()
//    @State private var error: String?
//    @State private var showError = false
//
//    var body: some View {
//        VStack {
//            TextField("Search Scryfall.com", text: $query)
//                .textFieldStyle(.roundedBorder)
//                .autocorrectionDisabled(true)
//                .textInputAutocapitalization(.never)
//                .onSubmit {
//                    search(query: query)
//                }
//
//            if loading {
//                ProgressView()
//            } else if cards.isEmpty {
//                Text("Perform a search to view cards")
//            } else {
//                LazyVGrid(columns: columns) {
//                    ForEach(cards) { card in
//                        AsyncImage(url: card.getImageURL(type: .normal)) { image in
//                            image
//                                .resizable()
//                                .scaledToFit()
//                        } placeholder: {
//                            Text(card.name)
//                            ProgressView()
//                        }
//                    }
//                }
//            }
//
//            Spacer()
//        }
//        .alert("Error", isPresented: $showError, presenting: error, actions: { _ in }) { error in
//            Text(error)
//        }
//        .refreshable {
//            guard !query.isEmpty else { return }
//            search(query: query)
//        }
//        .padding()
//    }
//
//    private func search(query: String) {
//        error = nil
//        loading = true
//
//        Task {
//            do {
//                let results = try await client.searchCards(query: query)
//                await MainActor.run {
//                    cards = results.data
//                }
//            } catch {
//                await MainActor.run {
//                    showError = true
//                    self.error = error.localizedDescription
//                }
//            }
//
//            await MainActor.run {
//                loading = false
//            }
//        }
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
