//
//  Friend.swift
//  SolutionToFriendface
//
//  Created by FZJ on 2024/5/21.
//

import SwiftData
import Foundation

class Friend: Codable {
    var id: UUID
    var name: String
    
    static let testFriend = Friend(id: UUID(), name: "wxw")
    
    init(id: UUID, name: String) {
        self.id = id
        self.name = name
    }
}
