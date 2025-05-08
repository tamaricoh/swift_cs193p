//
//  CardFeatures.swift
//  Task3
//
//  Created by Tamar Cohen on 07/05/2025.
//


import SwiftUI

struct CardFeatures: Equatable {
  
  enum Symbol: CaseIterable {
    case diamond, squiggle, oval
  }
  enum Shading: CaseIterable {
    case solid, striped, open
  }

  enum CardColor: CaseIterable {
    case red, green, purple
  }

  enum NumberOfShape: Int, CaseIterable {
    case one = 1, two, three
  }

  var number: NumberOfShape
  var symbol: Symbol
  var shading: Shading
  var color: CardColor
}
