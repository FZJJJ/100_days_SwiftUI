//
//  HotProspectsApp.swift
//  HotProspects
//
//  Created by FZJ on 2024/6/14.
//

import SwiftData
import SwiftUI

@main
struct HotProspectsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Prospect.self)
    }
}
