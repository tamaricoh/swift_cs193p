//
//  Task4App.swift
//  Task4
//
//  Created by Tamar Cohen on 14/05/2025.
//

import SwiftUI

@main
struct Task4App: App {
    var body: some Scene {
        WindowGroup {
          BoardView(viewModel: SetViewModel())
        }
    }
}
