import SwiftUI

struct SearchView: View {
  @State private var query = ""

  var body: some View {
    TextField("Search for Magic: the Gathering cards", text: $query)
      .textFieldStyle(.roundedBorder)
      .padding()
  }
}
