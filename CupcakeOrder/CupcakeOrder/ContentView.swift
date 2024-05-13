//
//  ContentView.swift
//  CupcakeOrder
//
//  Created by FZJ on 2024/5/11.
//

import SwiftUI

struct ContentView: View {
    @State private var order = Order()
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Picker("选择你的口味",selection: $order.type) {
                        ForEach(Order.types.indices, id: \.self) {
                            Text(Order.types[$0])
                        }
                    }
                    Stepper("Number of cakes: \(order.quantity)", value: $order.quantity, in: 3...20)
                }
                Section {
                    Toggle("特殊的需求", isOn: $order.specialRequestEnabled)
                    if order.specialRequestEnabled {
                        Toggle("加糖霜", isOn: $order.extraFrosting)
                        Toggle("加饼干碎", isOn: $order.addSprinkles)
                    }
                }
                Section {
                    NavigationLink("派送信息") {
                        AddressView(order: order)
                    }
                }
            }
            .navigationTitle("点蛋糕🍰")
        }
    }
}

#Preview {
    ContentView()
}
