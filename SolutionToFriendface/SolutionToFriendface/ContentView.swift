//
//  ContentView.swift
//  SolutionToFriendface
//
//  Created by FZJ on 2024/5/21.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    
    @Environment(\.modelContext) var modelContext
    @Query(sort: \User.name) var users: [User]
    
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
                if users.isEmpty {
                    await loadData()
                }
            }
            .navigationTitle("FriendFace")
        }
    }
    func loadData() async {
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else { return }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
                
            if let decodedResponse = try decoder.decode([User]?.self, from: data) {
                for user in decodedResponse {
                    modelContext.insert(user)
                }
            } else {
                print("error")
            }
        } catch {
            print("Failed to load data: \(error.localizedDescription)")
        }
    }
}

#Preview {
    ContentView()
}
