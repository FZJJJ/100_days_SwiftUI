//
//  ContentView.swift
//  HotProspects
//
//  Created by FZJ on 2024/6/14.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            UserView(filter: .none)
                .tabItem {
                    Label("Everyone", systemImage: "person.3")
                }
            UserView(filter: .contacted)
                .tabItem {
                    Label("Contacted", systemImage: "checkmark.circle")
                }
            UserView(filter: .uncontacted)
                .tabItem {
                    Label("Uncontacted", systemImage: "questionmark.circle")
                }
            MeView()
                .tabItem {
                    Label("Me", systemImage: "person.crop.square")
                }
        }
    }
}

#Preview {
    ContentView()
}
