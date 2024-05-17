//
//  BookWormApp.swift
//  BookWorm
//
//  Created by FZJ on 2024/5/15.
//

import SwiftData
import SwiftUI

@main
struct BookWormApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Book.self)
    }
}
