//
//  ContentView.swift
//  HabitTrack
//
//  Created by FZJ on 2024/5/9.
//

import SwiftUI

struct ContentView: View {
    var activities = Activities()
    @State private var showingAddView = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(activities.items, id: \.id) {item in
                    NavigationLink(destination: ItemView(activities: activities, selectedItem: item)) {
                        HStack {
                            Text(item.name)
                            Spacer()
                            Text("\(item.logs)")
                        }
                        .foregroundColor(chooseColor(for: item.type))
                    }
                }
                .onDelete(perform: { indexSet in
                    activities.items.remove(atOffsets: indexSet)
                })
            }
            .navigationTitle("习惯追踪")
            .toolbar {
                Button(){
                    showingAddView = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddView, content: {
                AddView(activities: activities)
            })
        }
    }
    func chooseColor(for type: String) -> Color{
        switch type {
        case "运动":
            return .red
        case "音乐":
            return .blue
        case "美术":
            return .green
        case "其他":
            return .gray
        default:
            return .white
        }
    }
}

#Preview {
    ContentView()
}
