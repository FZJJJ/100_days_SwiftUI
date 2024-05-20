//
//  AddView.swift
//  iExpenseApp
//
//  Created by FZJ on 2024/4/25.
//

import SwiftData
import SwiftUI

struct AddView: View {
    @Environment(\.modelContext) var modelContext

    @State private var name = "Expense Name"
    @State private var type = "Personal"
    @State private var amount = 0.0

    @Environment(\.dismiss) var dismiss

    var body: some View {
        //NavigationStack {
            Form {
                //TextField("Name", text: $name)

                Picker("Type", selection: $type) {
                    ForEach(Expense.types, id: \.self) {
                        Text($0)
                    }
                }

                TextField("Amount", value: $amount, format: .currency(code: "USD"))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle($name)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let expense = Expense(name: name, type: type, amount: amount)
                        modelContext.insert(expense)
                        dismiss()
                    }
                }
            }
        //}
    }
}

#Preview {
    AddView()
}
