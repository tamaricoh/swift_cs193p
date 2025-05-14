//
//  SetViewModel.swift
//  Task3
//
//  Created by Tamar Cohen on 07/05/2025.
//

import SwiftUI

class SetViewModel : ObservableObject{

  @Published private var model = SetModel()

  var dealtCards: Array<SetModel.Card> {
    return model.dealtCards
  }

  var cards: Array<SetModel.Card> {
    return model.cards
  }

  func dealMoreCards() {
    model.dealMoreCards(dealBatchSize: 1)
    objectWillChange.send()
  }

  func choose(_ card: SetModel.Card) {
    model.choose(card)
    objectWillChange.send()
  }

  func shuffle() {
    model.shuffle()
    objectWillChange.send()
  }

  func score() -> String {
    return String(model.score)
  }

  func newGame() {
    model = SetModel()
  }
}
