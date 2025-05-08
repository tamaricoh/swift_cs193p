//
//  Task3App.swift
//  Task3
//
//  Created by Tamar Cohen on 07/05/2025.
//

import SwiftUI

@main
struct Task3App: App {
    var body: some Scene {
        WindowGroup {
            BoardView(viewModel: SetViewModel())
        }
    }
}

