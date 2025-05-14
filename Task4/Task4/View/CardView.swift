//
//  CardView.swift
//  Task3
//
//  Created by Tamar Cohen on 07/05/2025.
//

import SwiftUI

struct CardView: View {

  let card: SetModel.Card

  init (_ card: SetModel.Card) {
    self.card = card
  }

  var body: some View {
    let base = RoundedRectangle(cornerRadius: 12)
    return ZStack {
      base.fill(.white)
      if card.isMatched == 1 {
        base.strokeBorder(.green, lineWidth: card.chosen ? 6 : 2)
      }
      if card.isMatched == 0 {
        base.strokeBorder(card.chosen ? .orange : .black, lineWidth: card.chosen ? 6 : 2)
      }
      if card.isMatched == -1 {
        base.strokeBorder(.red, lineWidth: card.chosen ? 6 : 2)
      }
      GeometryReader { geometry in
        let shapeSize = geometry.size.width / 3
        createCard(features: card.content, shapeSize: shapeSize)
          .frame(width: geometry.size.width, height: geometry.size.height)
      }
    }
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
