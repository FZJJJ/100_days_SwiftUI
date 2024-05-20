//
//  Expense.swift
//  iExpenseApp
//
//  Created by FZJ on 2024/5/20.
//

import Foundation
import SwiftData

@Model
class Expense: Identifiable {
    static let types = ["Personal", "Business"]
    
    var id = UUID()
    var name: String
    var type: String
    var amount: Double
    
    init(id: UUID = UUID(), name: String, type: String, amount: Double) {
        self.id = id
        self.name = name
        self.type = type
        self.amount = amount
    }
}
