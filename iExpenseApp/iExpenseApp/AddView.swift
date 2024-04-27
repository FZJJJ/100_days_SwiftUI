//
//  AddView.swift
//  iExpenseApp
//
//  Created by FZJ on 2024/4/25.
//

import SwiftUI

struct AddView: View {
    @Environment(\.dismiss) var dismiss
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = 0.0
    
    var expenses: Expenses
    
    let types = ["Personal", "Business"]
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("name", text: $name)
                
                Picker("type", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }
                
                TextField("amount", value: $amount, format: .currency(code: "USD"))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("Add new expense")
            .toolbar {
                Button("save") {
                    let item = ExpenseItem(name: name, type: type, amount: amount)
                    item.type == "Personal" ? expenses.items.insert(item, at: 0) : expenses.items.append(item)
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    AddView(expenses: Expenses())
}
