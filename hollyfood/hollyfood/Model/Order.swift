//
//  Order.swift
//  hollyfood
//
//  Created by Khairi on 6/12/2022.
//

import Foundation
import SwiftUI

struct Order: Identifiable, Codable, Hashable {
    
    var id : String
    var price : Float
    var user : String
    var restaurant : String
    var createdAt : String
    
    init(id: String, price: Float, user: String, restaurant: String, createdAt: String) {
        
        self.id = id
        self.price = price
        self.user = user
        self.restaurant = restaurant
        self.createdAt = createdAt
    }
    
    enum CodingKeys: String, CodingKey {
        
        case id = "_id"
        case price
        case user
        case restaurant
        case createdAt
    }
}

struct  OrderDataModel:Codable{
    let orders:[Order]
}

