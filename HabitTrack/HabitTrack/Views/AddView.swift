//
//  AddView.swift
//  HabitTrack
//
//  Created by FZJ on 2024/5/9.
//

import SwiftUI

struct AddView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var name = ""
    @State private var type = "运动"
    @State private var desription = ""
    let types = ["运动", "音乐", "美术", "其他"]
    var activities: Activities
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("活动名称", text: $name)
                Picker("活动种类", selection: $type){
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }
                TextField("写入备注", text: $desription)
            }
            .navigationTitle("填写信息")
            .toolbar {
                Button("保存"){
                    let item = HabitItem(name: name, type: type, description: desription)
                    activities.items.append(item)
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    AddView(activities: Activities())
}
