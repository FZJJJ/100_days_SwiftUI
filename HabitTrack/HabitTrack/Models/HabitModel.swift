//
//  HabitModel.swift
//  HabitTrack
//
//  Created by FZJ on 2024/5/9.
//

import Foundation

struct HabitItem: Identifiable, Codable {
    var id = UUID()
    var name: String
    var type = "运动"
    var description: String
    var logs = 0
}

@Observable
class Activities {
    var items = [HabitItem](){
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([HabitItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
        items = []
    }
}
