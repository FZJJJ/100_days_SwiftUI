//
//  ContentView-ViewModel.swift
//  MeetUp
//
//  Created by FZJ on 2024/6/11.
//

import Foundation

extension ContentView {
    @Observable
    class ViewModel {
        var personList: [Person] = [] {
            didSet {
                save()
            }
        }
        
        var sortedPersonList: [Person] {
            personList.sorted()
        }
        
        let path = FileManager().getDocumentDirectory
        let key = "personList"
        
        let locationFetcher = LocationFetcher()
        
        init() {
            do {
                let data = try Data(contentsOf: path.appending(path: key))
                personList = try JSONDecoder().decode([Person].self, from: data)
            } catch {
                personList = []
            }
        }
        
        private func save() {
            let url = path.appending(path: key)
            
            do {
                let data = try? JSONEncoder().encode(personList)
                try data?.write(to: url, options: [.atomic, .completeFileProtection])
            } catch {
                print("Data cannot be saved: \(error.localizedDescription)")
            }
        }
        
        func delete(index: IndexSet) {
            personList.remove(atOffsets: index)
        }
    }
}
