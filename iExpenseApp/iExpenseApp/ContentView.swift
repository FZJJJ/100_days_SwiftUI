//
//  ContentView.swift
//  iExpenseApp
//
//  Created by FZJ on 2024/4/25.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query var expenses: [Expense]
    
    @State private var path: [String] = []
    @State private var showingAddExpense = false
    @State private var types = Expense.types
    @State private var sortOrder = [
        SortDescriptor(\Expense.name),
        SortDescriptor(\Expense.amount, order: .reverse)
    ]
    
    var body: some View {
        NavigationStack(path: $path) {
            ExpensesView(types: types, sortOrder: sortOrder)
                .navigationTitle("iExpense")
                .toolbar {
                    Button("Add Expense", systemImage: "plus") {
                        //showingAddExpense = true
                        path.append("AddExpense")
                    }
                    Menu("Type") {
                        Picker("Type", selection: $types) {
                            Text("All").tag(Expense.types)
                            Text("Just Business").tag(["Business"])
                            Text("Just Personal").tag(["Personal"])
                        }
                    }
                    Menu("Sort", systemImage: "arrow.up.arrow.down") {
                        Picker("Sort", selection: $sortOrder) {
                            Text("Sort by Type")
                                .tag([
                                    SortDescriptor(\Expense.type),
                                    SortDescriptor(\Expense.name),
                                    SortDescriptor(\Expense.amount, order: .reverse)
                                ])
                            Text("Sort by Highest Amount")
                                .tag([
                                    SortDescriptor(\Expense.amount, order: .reverse),
                                    SortDescriptor(\Expense.type),
                                    SortDescriptor(\Expense.name)
                                ])
                        }
                    }
                }
                .navigationDestination(for: String.self) { i in
                    AddView()
                }
            //.sheet(isPresented: $showingAddExpense) {
            //    AddView(expenses: expenses)
            //}
        }
    }
    func deleteExpense(at offsets: IndexSet) {
        for offset in offsets {
            let expense = expenses[offset]
            modelContext.delete(expense)
        }
    }
}

#Preview {
    ContentView()
}
