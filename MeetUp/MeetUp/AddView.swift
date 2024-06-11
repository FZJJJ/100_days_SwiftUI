//
//  AddView.swift
//  MeetUp
//
//  Created by FZJ on 2024/6/11.
//

import PhotosUI
import SwiftUI

struct AddView: View {
    @Environment(\.dismiss) var dismiss
    @State private var viewModel: ViewModel
    
    var save: (Person) -> Void
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    Section("Person Info") {
                        HStack {
                            Spacer()
                            if(viewModel.dataImage != nil) {
                                if let imageOfPerson = viewModel.personPhoto {
                                    imageOfPerson
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 50, height: 50)
                                        .clipShape(.circle)
                                } else {
                                    ProgressView()
                                        .frame(width: 50, height: 50)
                                }
                            } else {
                                PhotosPicker(selection: $viewModel.selectedPhoto, matching: .any(of: [.images, .not(.screenshots)])) {
                                    Image(systemName: "photo.badge.plus")
                                        .imageScale(.large)
                                        .overlay(
                                            Circle()
                                                .stroke(lineWidth: 3)
                                                .frame(width: 50, height: 50)
                                        )
                                        .padding()
                                }
                            }
                            Spacer()
                        }
                        TextField("Name of person", text: $viewModel.name)
                    }
                }
                .padding()
                Button {
                    let newPerson = viewModel.addNewPerson()
                    save(newPerson)
                    dismiss()
                } label: {
                    Text("Save")
                        .frame(maxWidth: .infinity, maxHeight: 50)
                        .background(.blue)
                        .foregroundStyle(.white)
                        .clipShape(.capsule)
                        .font(.title.bold())
                }
                .padding(.bottom, 50)
                .padding(.horizontal)
            }
            .navigationTitle("Add person")
        }
        .onChange(of: viewModel.selectedPhoto) {
            Task {
                do {
                    try await viewModel.loadImage()
                } catch {
                    print("Error: \(error.localizedDescription)")
                }
            }
        }
        .onAppear(perform: viewModel.locationFetcher.start)
    }
    init(locationFetcher: LocationFetcher, save: @escaping (Person) -> Void) {
        _viewModel = State(initialValue: ViewModel(locationFetcher: locationFetcher))
        self.save = save
    }
}

#Preview {
    AddView(locationFetcher: LocationFetcher()) {_ in}
}
