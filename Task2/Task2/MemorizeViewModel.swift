//
//  MemorizeViewModel.swift
//  Task2
//
//  Created by Tamar Cohen on 05/05/2025.
//

import SwiftUI

class EmojiMemoryGame : ObservableObject{
  private static let heartEmojis: [String] = ["❤️", "🧡", "💛", "💚", "💙", "💜"]

  private static func createMemoryGame(theme: Theme) -> MemoryGame<String> {
    let emojiCount = theme.emojis.count
    let pairCount = max(2, min(theme.numOfPairs ?? Int.random(in: 2...emojiCount), emojiCount))
    let emojis = theme.emojis.shuffled()
    
    return MemoryGame(numberOfPairs: min(emojis.count, pairCount)) { pairIndex in
      if theme.emojis.indices.contains(pairIndex) {
        return emojis[pairIndex]
      } else {
        return "⁉️"
      }
    }
  }

  @Published private var model: MemoryGame<String>
  private(set) var theme: Theme

  init() {
    theme = themes.randomElement()!
    model = EmojiMemoryGame.createMemoryGame(theme: theme)
  }

  var cards: Array<MemoryGame<String>.Card> {
    return model.cards
  }

  func choose(_ card: MemoryGame<String>.Card) {
    model.choose(card)
  }

  func shuffle() {
    model.shuffle()
    objectWillChange.send()
  }

  func newGame() {
    theme = themes.randomElement()!
    model = EmojiMemoryGame.createMemoryGame(theme: theme)
  }

  func score() -> String {
      return String(model.score)
  }

  var color: Color {
      theme.uiColor
  }
}
