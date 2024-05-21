//
//  NaviView.swift
//  SolutionToFriendface
//
//  Created by FZJ on 2024/5/21.
//

import SwiftUI

struct NaviView: View {
    var user: User
    var body: some View {
        HStack {
            Text("\(user.name)")
            Text("\(user.age)")
            Image(systemName: "circle.fill")
                .font(.system(size: 10))
                .foregroundStyle(user.isActive ? .green : .gray)
        }
    }
}

#Preview {
    NaviView(user: User.testUser)
}
