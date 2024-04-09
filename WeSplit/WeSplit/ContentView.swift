//
//  ContentView.swift
//  WeSplit
//
//  Created by FZJ on 2024/4/2.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numOfPeople = 2
    @State private var tipPercentage = 10
    @FocusState private var amountIsFocused: Bool
   
//    let tipPercentages = [0, 5, 10, 20, 30]
    
    var totalAmount: Double {
        return (1 + Double(tipPercentage)/100) * checkAmount
    }
    
    var finalAmount: Double {
        return totalAmount / Double(numOfPeople+2)
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "CNY"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of People", selection: $numOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                        .pickerStyle(.navigationLink)
                    }
                }
                
                Section("What's your prefered tip?") {
                    Picker("Tip Percentage", selection: $tipPercentage) {
//                        ForEach(tipPercentages, id: \.self) {
//                            Text($0, format: .percent)
                        ForEach(0..<101) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("The total amount") {
                    Text(totalAmount, format: .currency(code: Locale.current.currency?.identifier ?? "CNY"))
                }
                
                Section("The amount per people") {
                    Text(finalAmount, format: .currency(code: Locale.current.currency?.identifier ?? "CNY"))
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                if(amountIsFocused) {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
