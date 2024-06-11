//
//  Person.swift
//  MeetUp
//
//  Created by FZJ on 2024/6/11.
//

import Foundation
import SwiftUI

struct Person: Codable, Identifiable, Hashable, Comparable {
    var id: UUID
    let dataImage: Data
    let name: String
    let location: Location
    
    var swiftUiImage: Image {
        let uiImage = UIImage(data: dataImage)
        let image = Image(uiImage: uiImage ?? UIImage())
        return image
    }
    
    static func < (lhs: Person, rhs: Person) -> Bool {
        lhs.name < rhs.name
    }
    static func == (lhs: Person, rhs: Person) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static var personExample = Person(id: UUID(), dataImage: Data(), name: "Peter", location: Location(latitude: 48.7758, longtitude: 9.1829))
}
