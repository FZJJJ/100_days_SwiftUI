//
//  SolutionToFriendfaceApp.swift
//  SolutionToFriendface
//
//  Created by FZJ on 2024/5/21.
//

import SwiftData
import SwiftUI

@main
struct SolutionToFriendfaceApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}
