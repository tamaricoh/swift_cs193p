//
//  MemorizeThemes.swift
//  Task2
//
//  Created by Tamar Cohen on 06/05/2025.
//

//import Foundation
import SwiftUI

struct Theme {
  let name: String
  let emojis: [String]
  let numOfPairs: Int?
  let color: String

  var uiColor: Color {
    switch color.lowercased() {
    case "red": return .red
    case "blue": return .blue
    case "green": return .green
    case "pink": return .pink
    case "orange": return .orange
    case "purple": return .purple
    case "gray": return .gray
    case "yellow": return .yellow
    case "brown": return .brown
    default:
      return .accentColor // Fallback color
    }
  }
}

let heartEmojis: [String] = ["❤️", "🧡", "💛", "💚", "💙", "💜"] // 6
let girlyEmojis: [String] = ["💄", "💅", "👠", "🎀", "👡", "🌸", "💍"] // 7
let pinkEmojis: [String] = ["💖", "🌸", "🎀", "🩷", "💐", "🛍️", "👚", "👛"] // 8
let animalEmojis: [String] = ["🐶", "🐱", "🐭", "🐰", "🦊", "🐻", "🐼"] // 7
let foodEmojis: [String] = ["🍎", "🍔", "🍕", "🍩", "🍓", "🍇"] // 6
let sportsEmojis: [String] = ["⚽️", "🏀", "🏈", "🎾", "🥎", "🏐", "🏓", "🏸", "⛳️"] // 9

let themes = [
    Theme(name: "Hearts", emojis: heartEmojis, numOfPairs: 6, color: "red"), // reg
    Theme(name: "Pink", emojis: pinkEmojis, numOfPairs: 10, color: "pink"), // numOfPairs >> emojis.count
    Theme(name: "Girly", emojis: girlyEmojis, numOfPairs: nil, color: "purple"), // numOfPairs == nil
    Theme(name: "Animals", emojis: animalEmojis, numOfPairs: 7, color: "brownnn"), // not a real color
    Theme(name: "Food", emojis: foodEmojis, numOfPairs: 6, color: "orange"),
    Theme(name: "Sports", emojis: sportsEmojis, numOfPairs: 9, color: "blue")
]
