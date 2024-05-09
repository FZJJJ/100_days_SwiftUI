//
//  Item.swift
//  HabitTrack
//
//  Created by FZJ on 2024/5/9.
//

import SwiftUI

struct ItemView: View {
    var activities: Activities
    @State var selectedItem: HabitItem

    var body: some View {
        VStack(alignment: .center, spacing: 32) {
            Text(selectedItem.name)
                .font(.title.bold())
                .multilineTextAlignment(.center)
            Text(selectedItem.type)
                .font(.subheadline)
            Text(selectedItem.description)
                .font(.headline)
                .multilineTextAlignment(.center)
            Text("已经完成\(selectedItem.logs)次")
                .font(.headline)
            Stepper("累计次数", onIncrement: {
                selectedItem.logs += 1
                save()
            }, onDecrement: {
                selectedItem.logs -= 1
                save()
            })
            .labelsHidden()
        }
    }
    func save() {
        guard let index = activities.items.firstIndex(where: {$0.id == selectedItem.id}) else { return }
        activities.items[index].logs = selectedItem.logs
    }
}

#Preview {
    ItemView(activities: Activities(), selectedItem: HabitItem(name: "打乒乓球🏓", description: "很开心的运动"))
}
