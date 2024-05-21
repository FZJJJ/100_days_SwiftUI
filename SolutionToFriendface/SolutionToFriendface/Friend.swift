//
//  Friend.swift
//  SolutionToFriendface
//
//  Created by FZJ on 2024/5/21.
//

import Foundation

struct Friend: Codable, Hashable, Identifiable {
    let id: UUID
    let name: String
    
    static let testFriend = Friend(id: UUID(), name: "wxw")
}
