//
//  DetailView.swift
//  SolutionToFriendface
//
//  Created by FZJ on 2024/5/21.
//

import SwiftUI

struct DetailView: View {
    var user: User
    var body: some View {
        //        NavigationStack {
        Form {
            Section("关于TA") {
                Text(user.about)
            }
            
            Section("具体信息") {
                Text("地址：\(user.address)")
                Text("公司：\(user.company)")
                Text("邮箱：\(user.email)")
            }
            
            Section("朋友圈") {
                ForEach(user.friends) { friend in
                    Text(friend.name)
                }
            }
            
            Section("标签") {
                ForEach(user.tags, id: \.self) { tag in
                    Text(tag)
                }
            }
        }
        .navigationTitle("资料卡")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                NaviView(user: user)
            }
        }
    }
//    }
}

#Preview {
    DetailView(user: .testUser)
}
