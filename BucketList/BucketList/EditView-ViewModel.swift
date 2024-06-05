//
//  EditView-ViewModel.swift
//  BucketList
//
//  Created by FZJ on 2024/6/5.
//

import Foundation

extension EditView {
    @Observable
    class EditViewModel {
        enum LoadingState {
            case loading, loaded, failed
        }
        
        var location: Location
        var name: String
        var description: String
        var loadingState = LoadingState.loading
        var pages = [Page]()
        init(location: Location) {
            self.location = location
            self.name = location.name
            self.description = location.description
        }
        
        func fetchNearbyPlaces() async {
            let urlString = "https://en.wikipedia.org/w/api.php?ggscoord=\(location.latitude)%7C\(location.longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"

            
            guard let url = URL(string: urlString) else {
                print("Bad url: \(urlString)")
                return
            }
            
            do {
                let(data, _) = try await URLSession.shared.data(from: url)
                print(1)
                let items = try JSONDecoder().decode(Result.self, from: data)
                print(2)
                pages = items.query.pages.values.sorted()
                print(3)
                loadingState = .loaded
            } catch {
                loadingState = .failed
            }
        }
        
        func save() -> Location {
            var newLocation = location
            newLocation.name = name
            newLocation.description = description
            newLocation.id = UUID()
            return newLocation
        }
    }
}
