//
//  AddressView.swift
//  CupcakeOrder
//
//  Created by FZJ on 2024/5/11.
//

import SwiftUI

struct AddressView: View {
    @Bindable var order: Order
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("姓名", text: $order.distribution.name)
                    TextField("地址", text: $order.distribution.address)
                    TextField("城市", text: $order.distribution.city)
                    TextField("邮编", text: $order.distribution.zip)
                }
                Section {
                    NavigationLink("提交") {
                        CheckoutView(order: order)
                    }
                    .disabled(order.checkoutValid == false)
                }
            }
            .navigationTitle("配送信息🍰")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    AddressView(order: Order())
}
