//
//  iExpenseAppApp.swift
//  iExpenseApp
//
//  Created by FZJ on 2024/4/25.
//

import SwiftUI
import SwiftData

@main
struct iExpenseAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Expense.self)
    }
}
