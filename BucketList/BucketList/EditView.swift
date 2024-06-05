//
//  EditView.swift
//  BucketList
//
//  Created by FZJ on 2024/5/31.
//

import SwiftUI

struct EditView: View {
    @Environment(\.dismiss) var dismiss
    var onSave: (Location) -> Void
    @State private var editViewModel: EditViewModel
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Place name", text: $editViewModel.name)
                    TextField("Descrption", text: $editViewModel.description)
                }
                
                Section("Nearby...") {
                    switch editViewModel.loadingState {
                    case .loading:
                        Text("Loading...")
                    case .loaded:
                        ForEach(editViewModel.pages, id: \.pageid) { page in
                            Text(page.title)
                                .font(.headline)
                            + Text(":") +
                            Text("Page description here")
                                .italic()
                        }
                    case .failed:
                        Text("Please try again")
                    }
                }
            }
            .navigationTitle("Place details")
            .toolbar {
                Button("Save") {
                    let newLocation = editViewModel.save()
                    onSave(newLocation)
                    dismiss()
                }
            }
            .task {
                await editViewModel.fetchNearbyPlaces()
            }
        }
    }
    init(location: Location, onSave: @escaping (Location) -> Void) {
        _editViewModel = State(initialValue: EditViewModel(location: location))
        self.onSave = onSave
    }
    
}

#Preview {
    EditView(location: .example){ _ in }
}
