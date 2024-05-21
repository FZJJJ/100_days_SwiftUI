//
//  User.swift
//  SolutionToFriendface
//
//  Created by FZJ on 2024/5/21.
//

import Foundation

struct User: Codable, Hashable, Identifiable {
    let id: UUID
    let isActive: Bool
    let name: String
    let age: Int
    let company: String
    let email: String
    let address: String
    let about: String
    let registered: Date
    let tags: [String]
    let friends: [Friend]
    
    static let testUser = User(
        id: UUID(),
        isActive: true,
        name: "FZJ",
        age: 21,
        company: "NWPU",
        email: "2919839271@qq.com",
        address: "海1C",
        about: "什么都没有，很无趣的人",
        registered: Date.now,
        tags: ["1", "2", "3"],
        friends: [Friend.testFriend]
        )
        
}
