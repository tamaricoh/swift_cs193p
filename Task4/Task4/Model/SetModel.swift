//
//  SetModel.swift
//  Task3
//
//  Created by Tamar Cohen on 07/05/2025.
//

import Foundation

struct SetModel {
  private(set) var cards: [Card]
  private(set) var dealtCards: [Card] = []
  private(set) var chosenCards: [Card] = []

  private let initialDealCount = 16
  var score = 0

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
    dealInitialCards()
  }

  struct Card : Equatable, Identifiable{
    var isMatched = 0
    var chosen = false
    var content: CardFeatures
    var id: String
  }

  mutating func dealInitialCards() {
    let initialCards = cards.prefix(initialDealCount)
    dealtCards = Array(initialCards)
    cards.removeFirst(initialCards.count)
  }

  mutating func dealMoreCards(dealBatchSize: Int) {
    let nextCards = cards.prefix(dealBatchSize)
    dealtCards.append(contentsOf: nextCards)
    cards.removeFirst(nextCards.count)
  }

  mutating func choose(_ card: Card) {
    if chosenCards.count == 3 {
      if checkSet(){
        discard()
      }
      unChoose()
    }
    if let chosenDealtIndex = dealtCards.firstIndex(where: { $0.id == card.id }) {
      if let chosenIndex = chosenCards.firstIndex(where: { $0.id == card.id }) {
        dealtCards[chosenDealtIndex].chosen = false
        chosenCards.remove(at: chosenIndex)
      }
      else {
        if chosenCards.count < 3 {
          dealtCards[chosenDealtIndex].chosen = true
          chosenCards.append(card)
        }
        if chosenCards.count == 3 {
          if checkSet(){
            isMatchHandler(status: 1)
            score += 1
          }
          else {
            isMatchHandler(status: -1)
          }
        }
      }
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
    dealtCards = dealtCards.filter { !chosenIDs.contains($0.id) }
    dealMoreCards(dealBatchSize: initialDealCount - dealtCards.count)
  }

  mutating func unChoose() {
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
