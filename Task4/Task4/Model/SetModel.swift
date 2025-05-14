//
//  SetModel.swift
//  Task3
//
//  Created by Tamar Cohen on 07/05/2025.
//

import Foundation

struct SetModel {
  private(set) var dealtCards: [Card] = []
  private(set) var cards: [Card]
  private(set) var discardedCards: [Card] = []
  private(set) var chosenCards: [Card] = []

  private let initialDealCount = 12
  private let maxDealCount = 20
  var score = 0
  var isGaming = false

  init() {
    cards = []
    for symbol in CardFeatures.Symbol.allCases {
      for shading in CardFeatures.Shading.allCases {
        for color in CardFeatures.CardColor.allCases {
          for number in CardFeatures.NumberOfShape.allCases {
            let features = CardFeatures(
              number: number,
              symbol: symbol,
              shading: shading,
              color: color
            )
            let card = Card(content: features, id: UUID().uuidString)
            cards.append(card)
          }
        }
      }
    }
    cards.shuffle()
  }

  struct Card : Equatable, Identifiable{
    var isMatched = 0
    var isFaceUp = false
    var chosen = false
    var content: CardFeatures
    var id: String
  }

  mutating func newGame() {
    resetCards()
    resetState()
    cards.shuffle()
  }

  private mutating func resetCards() {
    cards = cards + discardedCards + dealtCards
    for i in cards.indices {
      cards[i].isFaceUp = false
      cards[i].isMatched = 0
      cards[i].chosen = false
    }
  }

  private mutating func resetState() {
    dealtCards = []
    discardedCards = []
    chosenCards = []
    score = 0
  }

  mutating func discardSet() {
    if chosenCards.count == 3 {
      if checkSet(){
        discard()
      }
      resetChosenCards()
    }
  }

  mutating func dealMoreCards(dealBatchSize: Int) {
    discardSet()
    if isGaming && dealtCards.count < maxDealCount {
      let nextCards = drawFromDeck(count: dealBatchSize)
      flipNewCards(nextCards)
    }
  }

  private mutating func drawFromDeck(count: Int) -> [Card] {
    let drawn = cards.prefix(count)
    dealtCards.append(contentsOf: drawn)
    cards.removeFirst(drawn.count)
    return Array(drawn)
  }

  private mutating func flipNewCards(_ cards: [Card]) {
    for i in (dealtCards.count - cards.count)..<dealtCards.count {
      dealtCards[i].isFaceUp = true
    }
  }


  mutating func choose(_ card: Card) {
    discardSet()

    guard let dealtIndex = indexOfDealtCard(matching: card) else { return }

    if isCardAlreadyChosen(card) {
      unselectCard(at: dealtIndex, card: card)
    } else {
      selectCard(at: dealtIndex, card: card)
    }

    if chosenCards.count == 3 {
      if checkSet() {
        isMatchHandler(status: 1)
        score += 1
      } else {
        isMatchHandler(status: -1)
      }
    }
  }

  private func indexOfDealtCard(matching card: Card) -> Int? {
    dealtCards.firstIndex(where: { $0.id == card.id })
  }

  private func isCardAlreadyChosen(_ card: Card) -> Bool {
    chosenCards.contains(where: { $0.id == card.id })
  }

  private mutating func unselectCard(at index: Int, card: Card) {
    dealtCards[index].chosen = false
    chosenCards.removeAll(where: { $0.id == card.id })
  }

  private mutating func selectCard(at index: Int, card: Card) {
    if chosenCards.count < 3 {
      dealtCards[index].chosen = true
      chosenCards.append(card)
    }
  }

  func checkSet() -> Bool {
    let firstContent = chosenCards[0].content
    let secondContent = chosenCards[1].content
    let thirdContent = chosenCards[2].content
    return checkCondition(first: firstContent.number, second: secondContent.number, third: thirdContent.number) &&
    checkCondition(first: firstContent.symbol, second: secondContent.symbol, third: thirdContent.symbol) &&
    checkCondition(first: firstContent.shading, second: secondContent.shading, third: thirdContent.shading) &&
    checkCondition(first: firstContent.color, second: secondContent.color, third: thirdContent.color)
  }

  func checkCondition<T: Equatable>(first: T, second: T, third: T) -> Bool {
    // All have same T or three different Ts
    return (first == second && second == third) || (first != second && second != third && first != third)
  }

  mutating func isMatchHandler(status: Int){
    for i in dealtCards.indices {
      if chosenCards.contains(where: { $0.id == dealtCards[i].id }) {
        dealtCards[i].isMatched = status
      }
    }
  }

  mutating func discard() {
    let chosenIDs = Set(chosenCards.map { $0.id })
    let discarded = dealtCards.filter { chosenIDs.contains($0.id) }
    discardedCards.append(contentsOf: discarded)
    markDiscardedCardsUnchosen()
    dealtCards.removeAll { chosenIDs.contains($0.id) }
  }

  private mutating func markDiscardedCardsUnchosen() {
    for i in discardedCards.indices {
      discardedCards[i].chosen = false
    }
  }


  mutating func resetChosenCards() {
    for i in dealtCards.indices {
      if chosenCards.contains(where: { $0.id == dealtCards[i].id }) {
        dealtCards[i].chosen = false
        dealtCards[i].isMatched = 0
      }
    }
    chosenCards = []
  }

  mutating func shuffle() {
    dealtCards.shuffle()
  }
}

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
