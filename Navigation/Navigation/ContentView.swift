//
//  ContentView.swift
//  Navigation
//
//  Created by FZJ on 2024/5/6.
//

import SwiftUI
import Foundation

@Observable
class PathStore {
    var path: NavigationPath {
        didSet {
            save()
        }
    }
    private let savePath = URL.documentsDirectory.appending(path: "SavedPath")
    init () {
        if let data = try? Data(contentsOf: savePath) {
            if let decoded = try? JSONDecoder().decode([Int].self, from: data) {
                path = NavigationPath(decoded)
                return
            }
        }
        path = NavigationPath()
    }
    
    func save() {
        do {
            guard let representation = path.codable else {return}
            let data = try JSONEncoder().encode(representation)
            try data.write(to: savePath)
        } catch {
            print("Failed to save naviagtion data")
        }
    }
}

struct DetailView: View {
    var number: Int
    
    var body: some View {
        NavigationLink("Go to Rnadom Number", value: Int.random(in: 1...100))
            .navigationTitle("Number: \(number)")
    }
}

struct ContentView: View {
    @State private var pathStore = PathStore()
    
    var body: some View {
        NavigationStack(path: $pathStore.path) {
            DetailView(number: 0)
                .navigationDestination(for: Int.self) {i in
                    DetailView(number: i)
                }
        }
    }
}

#Preview {
    ContentView()
}
