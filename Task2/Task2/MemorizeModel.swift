//
//  MemorizeModel.swift
//  Task2
//
//  Created by Tamar Cohen on 05/05/2025.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
  private(set) var cards: Array<Card>
  var score = 0

  init(numberOfPairs: Int, cardContentFactory: (Int) -> CardContent) {
    cards = []
    for pairIndex in 0..<max(2, numberOfPairs) {
      let content = cardContentFactory(pairIndex)
      cards.append(Card(content: content, id: "\(pairIndex+1)A"))
      cards.append(Card(content: content, id: "\(pairIndex+1)B"))
    }
    cards.shuffle()

  }

  struct Card : Equatable, Identifiable{
    var isFaceUp = false
    var isMatched = false
    var seen = false
    var content: CardContent
    var id: String
  }

  var indexOfTheOneAndOnlyFaceUpCard: Int? {
      get { cards.indices.filter { index  in cards[index].isFaceUp }.only }
      set { cards.indices.forEach { cards[$0].isFaceUp = (newValue == $0) } }
  }

  mutating func choose(_ card: Card) {
    if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }) {
      if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched {
        if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
          if cards[chosenIndex].content == cards[potentialMatchIndex].content {
            cards[chosenIndex].isMatched = true
            cards[potentialMatchIndex].isMatched = true
            score += 2
          } else {
            score -= cards[chosenIndex].seen ? 1 : 0
            score -= cards[potentialMatchIndex].seen ? 1 : 0
          }
        } else {
          indexOfTheOneAndOnlyFaceUpCard = chosenIndex
        }
        cards[chosenIndex].isFaceUp = true
      }
      cards[chosenIndex].seen = true
    }
  }

  mutating func shuffle() {
    cards.shuffle()
  }
}

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
