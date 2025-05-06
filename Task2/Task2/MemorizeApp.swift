//
//  Task2App.swift
//  Task2
//
//  Created by Tamar Cohen on 05/05/2025.
//

import SwiftUI

@main
struct MemorizeApp: App {
  @StateObject var game = EmojiMemoryGame()
    var body: some Scene {
        WindowGroup {
          MemoryView(viewModel: game)
        }
    }
}
