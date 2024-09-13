//
//  CardView.swift
//

import ScryfallKit
import SwiftUI

struct CardView: View {
  var card: Card

  var body: some View {
    VStack {
      AsyncImage(url: card.getImageURL(type: .normal)) { image in
        image
          .resizable()
          .scaledToFit()
      } placeholder: {
        Text(card.name)
        ProgressView()
      }

      GroupBox {
        HStack {
          Text(card.name)
          Spacer()
          Text(card.manaCost ?? "")
        }

        Divider()

        Text(card.oracleText ?? "")
          .padding(.bottom)
        Text(card.flavorText ?? "")
          .italic()

        if let powerAndToughness = card.powerAndToughness {
          Divider()
          HStack {
            Spacer()
            Text(powerAndToughness)
          }
        }
      }
    }
  }
}

extension Card {
  var powerAndToughness: String? {
    guard let power, let toughness else { return nil }
    return "\(power)/\(toughness)"
  }
}

//struct SwiftUIView_Previews: PreviewProvider {
//    static var previews: some View {
//        SwiftUIView()
//    }
//}
