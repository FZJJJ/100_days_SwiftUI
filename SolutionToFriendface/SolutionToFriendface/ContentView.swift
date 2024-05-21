//
//  ContentView.swift
//  SolutionToFriendface
//
//  Created by FZJ on 2024/5/21.
//

import SwiftUI

struct ContentView: View {
    @State private var users = [User]()
    var body: some View {
        NavigationStack {
            List {
                ForEach(users) { user in
                    NavigationLink(value: user) {
                        HStack {
                            Circle()
                                .frame(width: 7)
                                .foregroundStyle(user.isActive ? .green : .gray)
                            Text(user.name)
                        }
                    }
                }
            }
            .navigationDestination(for: User.self) { user in
                DetailView(user: user)
            }
            .task {
                await loadData()
            }
            .navigationTitle("FriendFace")
        }
    }
    func loadData() async {
        guard users.isEmpty else { return }
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else { return }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            users = try decoder.decode([User].self, from: data)
        } catch {
            print("Failed to load data: \(error.localizedDescription)")
        }
    }
}

#Preview {
    ContentView()
}
