//
//  ContentView.swift
//  MeetUp
//
//  Created by FZJ on 2024/6/11.
//

import SwiftUI

struct ContentView: View {
    @State private var viewModel = ViewModel()
    @State private var addViewSheet = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.sortedPersonList, id: \.self) { person in
                    HStack {
                        person.swiftUiImage
                            .resizable()
                            .scaledToFill()
                            .frame(width: 50, height: 50)
                            .clipShape(.circle)
                        NavigationLink(person.name, value: person)
                    }
                }
                .onDelete(perform: viewModel.delete)
            }
            .navigationTitle("iMeet")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        addViewSheet = true
                    } label: {
                        Label("Add", systemImage: "plus.circle")
                    }
                }
            }
            .navigationDestination(for: Person.self) { person in
                DetailView(person: person, locationFetcher: viewModel.locationFetcher)
            }
        }
        .sheet(isPresented: $addViewSheet) {
            AddView(locationFetcher: viewModel.locationFetcher) { person in
                viewModel.personList.append(person)
            }
        }
    }
}

#Preview {
    ContentView()
}
