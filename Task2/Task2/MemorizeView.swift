//
//  MemorizeView.swift
//  Task2
//
//  Created by Tamar Cohen on 05/05/2025.
//

import SwiftUI

struct MemoryView: View {
  @ObservedObject var viewModel: EmojiMemoryGame
  var body: some View {
    VStack {
      Text("\(viewModel.theme.name) Memorize Game").font(.title)
      ScrollView {
        cards
          .animation(.default, value: viewModel.cards)
      }
      Spacer()
      HStack{
        Button(action: {
          viewModel.shuffle()
        }, label: {
          VStack(spacing: 5) {
            Image(systemName: "shuffle.circle").font(.largeTitle)
            Text("Shuffle")
          }
          .foregroundColor(viewModel.color)
        })
        Spacer()
        Text("Score: \(viewModel.score())")
          .font(.title)
        Spacer()
        Button(action: {
          viewModel.newGame()
        }, label: {
          VStack(spacing: 5) {
            Image(systemName: "plus.circle").font(.largeTitle)
            Text("New Game")
          }
          .foregroundColor(viewModel.color)
        })

      }
    }
    .padding()
  }

  var cards: some View {
    LazyVGrid(columns: [GridItem(.adaptive(minimum: CGFloat(100 - (viewModel.cards.count - 3) * 2)), spacing: 0)], spacing: 0) {
      ForEach(viewModel.cards) { card in
        CardView(card)
          .aspectRatio(2/3, contentMode: .fit)
          .padding(4)
          .onTapGesture {
            viewModel.choose(card)
          }
      }
    }
    .foregroundColor(viewModel.color)
  }
}

struct CardView: View {
  let card: MemoryGame<String>.Card

  init (_ card: MemoryGame<String>.Card) {
    self.card = card
  }
  var body: some View {
    ZStack {
        let base = RoundedRectangle(cornerRadius: 12)
        Group {
            base.fill(.white)
            base.strokeBorder(lineWidth: 2)
          Text(card.content)
                .font(.system(size: 100))
                .minimumScaleFactor(0.01)
                .aspectRatio(1, contentMode: .fit)
        }
        .opacity(card.isFaceUp ? 1:0)
      base.fill().opacity(card.isFaceUp ? 0:1)
    }
  }
}
 
#Preview {
  MemoryView(viewModel: EmojiMemoryGame())
}
