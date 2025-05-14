//
//  CardView.swift
//  Task3
//
//  Created by Tamar Cohen on 07/05/2025.
//

import SwiftUI

struct CardView: View {

  let card: SetModel.Card
  @State private var flipped = false


  init (_ card: SetModel.Card) {
    self.card = card
  }

  var body: some View {
    let base = RoundedRectangle(cornerRadius: 12)
    ZStack {
      if card.isFaceUp {
        ZStack {
          base.fill(.white)
          let borderColor: Color = {
              switch card.isMatched {
              case 1: return card.chosen ? .green : .black
              case 0: return card.chosen ? .orange : .black
              case -1: return card.chosen ? .red : .black
              default: return .black
              }
          }()

          let borderWidth: CGFloat = card.chosen ? 6 : 2

          base.strokeBorder(borderColor, lineWidth: borderWidth)
          GeometryReader { geometry in
            let shapeSize = geometry.size.width / 3
            createCard(features: card.content, shapeSize: shapeSize)
              .frame(width: geometry.size.width, height: geometry.size.height)
          }
        }
      } else {
        ZStack {
          base.fill(Color.purple)
          base.stroke(Color.white, lineWidth: 2)
        }
      }
    }
    .onAppear {
      if card.isFaceUp && card.isMatched == 0 && !flipped {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
          flipped = true
        }
      }
    }
    .rotation3DEffect(.degrees(flipped ? 0 : 180), axis: (0, 1, 0))
    .animation(.easeInOut(duration: 0.5), value: flipped)
    .aspectRatio(2/3, contentMode: .fit)
    .frame(minWidth: 80, idealWidth: 100, maxWidth: .infinity,
           minHeight: 120, idealHeight: 150, maxHeight: .infinity)
  }


  @ViewBuilder
  func createCard(features: CardFeatures, shapeSize: CGFloat) -> some View {
    VStack {
      ForEach(0..<features.number.rawValue, id: \.self) { _ in
        switch features.symbol {
        case .diamond:
          createCardAccToShape(shape: Diamond(), features: features)
            .frame(height: shapeSize)
        case .squiggle:
          createCardAccToShape(shape: Capsule(), features: features)
            .frame(height: shapeSize)
        case .oval:
          createCardAccToShape(shape: Ellipse(), features: features)
            .frame(height: shapeSize)
        }
      }
    }
    .padding()
  }

  @ViewBuilder
  func createCardAccToShape<S: Shape>(shape: S, features: CardFeatures) -> some View {
    let color: Color = {
      switch features.color {
      case .red: return .red
      case .green: return .green
      case .purple: return .purple
      }
    }()

    switch features.shading {
    case .solid:
      shape.fill(color)
    case .striped:
      shape
        .stroke(color, lineWidth: 1)
        .background(shape.fill(color.opacity(0.2)))
    case .open:
      shape.stroke(color, lineWidth: 2)
    }
  }
}

#Preview {
  let feature = CardFeatures(
    number: .three,
    symbol: .oval,
    shading: .striped,
    color: .red
  )

  let card = SetModel.Card(
    content: feature,
    id: "1"
  )

  CardView(card)

  let feature2 = CardFeatures(
    number: .two,
    symbol: .diamond,
    shading: .striped,
    color: .purple
  )

  let card2 = SetModel.Card(
    content: feature2,
    id: "2"
  )

  CardView(card2)
}
