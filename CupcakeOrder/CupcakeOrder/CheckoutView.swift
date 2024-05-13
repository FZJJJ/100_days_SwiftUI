//
//  CheckoutView.swift
//  CupcakeOrder
//
//  Created by FZJ on 2024/5/12.
//

import SwiftUI

struct CheckoutView: View {
    var order: Order
    
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    @State private var showingAlert = false
    @State private var alertMessage = ""
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                        image
                            .resizable()
                            .scaledToFit()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(height: 233)
                    Text("您的最终消费金额为\(order.cost, format: .currency(code: "CNY"))")
                        .font(.title)
                    Button("确定下单") {
                        Task {
                            await placeHolder()
                        }
                    }
                        .padding()
                }
            }
            .navigationTitle("订单")
            .navigationBarTitleDisplayMode(.inline)
            .scrollBounceBehavior(.basedOnSize)
            .alert("谢谢",isPresented: $showingConfirmation) {
                Button("好的"){}
            } message: {
                Text(confirmationMessage)
            }
            .alert("错误", isPresented: $showingAlert) {
                Button("好的"){}
            } message: {
                Text(alertMessage)
            }
        }
    }
    func placeHolder() async {
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("Failed to encode order")
            return
        }
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            confirmationMessage = "您的\(decodedOrder.quantity)个\(Order.types[decodedOrder.type])蛋糕正在路上～"
            showingConfirmation = true
        } catch {
            showingAlert = true
            alertMessage = "Checkout Failed: \(error.localizedDescription)"
        }
    }
}

#Preview {
    CheckoutView(order: Order())
}
