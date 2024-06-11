//
//  Location.swift
//  MeetUp
//
//  Created by FZJ on 2024/6/11.
//

import Foundation
import MapKit

struct Location: Codable {
    let latitude: Double
    let longtitude: Double
    
    var location: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longtitude)
    }
}
