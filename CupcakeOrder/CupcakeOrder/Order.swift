//
//  Order.swift
//  CupcakeOrder
//
//  Created by FZJ on 2024/5/11.
//

import Foundation

@Observable
class Order: Codable{
    enum CodingKeys: String, CodingKey {
        case _type = "type"
        case _quantity = "quantity"
        case _specialRequestEnabled  = "specialRequestEnabled"
        case _extraFrosting = "extraFrosting"
        case _addSprinkles = "addSprinkles"
//        case _name = "name"
//        case _address = "address"
//        case _city = "city"
//        case _zip = "zip"
        
    }
    static let types = ["香草🌿", "草莓🍓", "黄油🧈", "彩虹🌈"]
    
    var type = 0
    var quantity = 3
    
    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    var extraFrosting = false
    var addSprinkles = false
    
    var distribution = Distribution() {
        didSet {
            if let encoded = try? JSONEncoder().encode(distribution) {
                UserDefaults.standard.set(encoded, forKey: "Distribution")
            }
        }
    }
    init() {
        if let savedDistribution = UserDefaults.standard.data(forKey: "Distribution") {
            if let decodedDistribution = try? JSONDecoder().decode(Distribution.self, from: savedDistribution) {
                distribution = decodedDistribution
                return
            }
        }
        distribution = Distribution()
    }
        
    var checkoutValid: Bool {
        if distribution.name.isEmpty || distribution.address.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || distribution.city.isEmpty || distribution.zip.isEmpty {
            return false
        }
        return true
    }
    
    var cost: Double {
        var cost = Double(10 * quantity)
        cost += Double(type) * 2.5
        if extraFrosting {
            cost += Double(5 * quantity)
        }
        if addSprinkles {
            cost += Double(3 * quantity)
        }
        return cost
    }
}

struct Distribution: Codable {
    var name: String = ""
    var address: String = ""
    var city: String = ""
    var zip: String = ""
}
