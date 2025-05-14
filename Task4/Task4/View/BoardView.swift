//
//  BoardView.swift
//  Task3
//
//  Created by Tamar Cohen on 07/05/2025.
//

import SwiftUI

struct BoardView: View {
  @ObservedObject var viewModel: SetViewModel
  private let aspectRatio: CGFloat = 2/3
  @Namespace private var cardNamespace

  var body: some View {
    VStack {
      Text("SCORE:  \(viewModel.score())")
      cards
      Spacer(minLength: 40)
      HStack {
        deck
        Spacer()
        discardPile
      }
      .padding(.horizontal)
      Spacer(minLength: 40)
      HStack{
        Button(action: {
          withAnimation (.easeInOut(duration: 1)){
            viewModel.shuffle()
          }
        }, label: {
          VStack(spacing: 5) {
            Image(systemName: "shuffle.circle").font(.title)
            Text("Shuffle")
          }
        })
        Spacer()
        Button(action: {
          withAnimation (.easeInOut(duration: 1)){
            viewModel.newGame()
          }
        }, label: {
          VStack(spacing: 5) {
            Image(systemName: "restart.circle").font(.title)
            Text("New Game")
          }
        })

      }
    }
    .padding()
  }

  var cards: some View {
    AspectVGrid(viewModel.dealtCards, aspectRatio: aspectRatio){ card in
      CardView(card)
        .padding(4)
        .matchedGeometryEffect(id: card.id, in: cardNamespace)
        .onTapGesture {
          withAnimation(.easeInOut(duration: 0.5)){
            viewModel.choose(card)
          }
        }
    }
  }

  private var deck: some View {
    ZStack {
      ForEach(viewModel.cards) { card in
        CardView(card)
          .padding(4)
          .matchedGeometryEffect(id: card.id, in: cardNamespace)
      }
    }
    .frame(width: 30, height: 30 / aspectRatio)
    .onTapGesture {
      withAnimation(.easeInOut(duration: 0.5)) {
        viewModel.dealMoreCards()
      }
    }
  }

  var discardPile: some View {
    ZStack {
      ForEach(viewModel.discardedCards) { card in
        CardView(card)
          .padding(4)
          .matchedGeometryEffect(id: card.id, in: cardNamespace)
      }
    }
    .frame(width: 30, height: 30 / aspectRatio)
  }

}

#Preview {
  BoardView(viewModel: SetViewModel())
}
