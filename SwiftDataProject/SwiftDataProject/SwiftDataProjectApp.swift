//
//  SwiftDataProjectApp.swift
//  SwiftDataProject
//
//  Created by FZJ on 2024/5/20.
//

import SwiftData
import SwiftUI

@main
struct SwiftDataProjectApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}
