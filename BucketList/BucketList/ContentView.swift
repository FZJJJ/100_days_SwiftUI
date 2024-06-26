//
//  ContentView.swift
//  BucketList
//
//  Created by FZJ on 2024/5/31.
//

import MapKit
import SwiftUI

struct ContentView: View {
    @State private var viewModel = ViewModel()
    @State private var switching = false
    
    let startPostion = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 34.4, longitude: 109),
            span: MKCoordinateSpan(latitudeDelta: 0.6, longitudeDelta: 0.6)
    )
        )
    var body: some View {
        if viewModel.isUnlocked {
            NavigationStack {
                MapReader { proxy in
                    Map(initialPosition: startPostion) {
                        ForEach(viewModel.locations) { location in
                            Annotation(location.name, coordinate: location.coordinate) {
                                Image(systemName: "star.circle")
                                    .resizable()
                                    .foregroundStyle(.red)
                                    .frame(width: 30, height: 30)
                                    .background(.white)
                                    .clipShape(.circle)
                                    .onLongPressGesture {
                                        viewModel.selectedPlace = location
                                    }
                            }
                        }
                    }
                    .mapStyle(switching ? .hybrid : .standard)
                    .onTapGesture { postion in
                        if let coordinate = proxy.convert(postion, from: .local) {
                            viewModel.addLocation(at: coordinate)
                        }
                    }
                    .sheet(item: $viewModel.selectedPlace) { place in
                        EditView(location: place) { newLocation in
                            viewModel.update(location: newLocation)
                        }
                    }
                    .navigationTitle("Xi'An")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        Button("switch") {
                            switching.toggle()
                        }
                    }
                }
            }
        }else {
            Button("Unlock to find locations", action: viewModel.authenticate)
                .padding()
                .background(.blue)
                .foregroundStyle(.white)
                .clipShape(.capsule)
                .alert("Authentication failed", isPresented: $viewModel.isUnlocked) {
                    Button("ok") {}
                } message: {
                    Text("please try again")
                }
        }
    }
}

#Preview {
    ContentView()
}
