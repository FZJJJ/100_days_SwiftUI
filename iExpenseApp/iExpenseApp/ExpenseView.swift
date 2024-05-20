//
//  ExpenseView.swift
//  iExpenseApp
//
//  Created by FZJ on 2024/5/20.
//

import Foundation
import SwiftData
import SwiftUI

struct ExpensesView: View {
    @Environment(\.modelContext) var modelContext
    @Query var expenses: [Expense]
    
    var body: some View {
        List {
            ForEach(expenses) { expense in
                HStack {
                    VStack(alignment: .leading) {
                        Text(expense.name)
                            .font(.headline)
                        Text(expense.type)
                    }
                    Spacer()
                    Text(expense.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
                .italic(expense.amount > 10)
                .bold(expense.amount >= 100)
                .foregroundColor(expense.amount < 10 ? .green : expense.amount < 100 ? .black : .red)
                .accessibilityElement()
                .accessibilityLabel("\(expense.name) $\(expense.amount.formatted())")
                .accessibilityHint("\(expense.type) expense")
                //                //})
            }
            .onDelete(perform: deleteExpense)
        }
    }
    
    init(types: [String], sortOrder: [SortDescriptor<Expense>]) {
        _expenses = Query(filter: #Predicate<Expense> { expense in
            types.contains(expense.type)
        }, sort: sortOrder)
    }
    
    func deleteExpense(at offsets: IndexSet) {
        for offset in offsets {
            let expense = expenses[offset]
            modelContext.delete(expense)
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Expense.self, configurations: config)
        return NavigationStack {
            ExpensesView(types: Expense.types, sortOrder: [
                 SortDescriptor(\Expense.name),
                 SortDescriptor(\Expense.amount, order: .reverse)
             ])
        }
        .modelContainer(container)
    } catch {
        return Text("Failed to create container: \(error.localizedDescription)")
    }
}
