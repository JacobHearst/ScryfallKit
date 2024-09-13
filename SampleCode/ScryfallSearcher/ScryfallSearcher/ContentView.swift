//
//  ContentView.swift
//  ScryfallSearcher
//

import ScryfallKit
import SwiftUI

struct ContentView: View {
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
        .autocorrectionDisabled(true)
        .textInputAutocapitalization(.never)
        .onSubmit {
          search(query: query)
        }

      if loading {
        ProgressView()
      } else if cards.isEmpty {
        Text("Perform a search to view cards")
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

      Spacer()
    }
    .alert("Error", isPresented: $showError, presenting: error, actions: { _ in }) { error in
      Text(error)
    }
    .refreshable {
      guard !query.isEmpty else { return }
      search(query: query)
    }
    .padding()
  }

  private func search(query: String) {
    error = nil
    loading = true

    Task {
      do {
        let results = try await client.searchCards(query: query)
        await MainActor.run {
          cards = results.data
        }
      } catch {
        await MainActor.run {
          showError = true
          self.error = error.localizedDescription
        }
      }

      await MainActor.run {
        loading = false
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
