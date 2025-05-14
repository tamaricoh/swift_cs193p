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

  var body: some View {
    VStack {
      Text("SCORE:  \(viewModel.score())")
      cards
      Spacer()
      HStack{
        Button(action: {
          withAnimation (.easeInOut(duration: 1)){
            viewModel.shuffle()
          }
        }, label: {
          VStack(spacing: 5) {
            Image(systemName: "shuffle.circle").font(.largeTitle)
            Text("Shuffle")
          }
        })
        Spacer()
        if !viewModel.cards.isEmpty {
          Button(action: {
            viewModel.dealMoreCards()
          }, label: {
            VStack(spacing: 5) {
              Image(systemName: "plus.circle").font(.largeTitle)
              Text("Deal One More")
            }
          })
        }
        Spacer()
        Button(action: {
          viewModel.newGame()
        }, label: {
          VStack(spacing: 5) {
            Image(systemName: "restart.circle").font(.largeTitle)
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
//        .aspectRatio(2/3, contentMode: .fit)
        .padding(4)
        .onTapGesture {
          withAnimation(.easeInOut(duration: 0.5)){
            viewModel.choose(card)
          }
        }
    }
  }
}

#Preview {
  BoardView(viewModel: SetViewModel())
}
