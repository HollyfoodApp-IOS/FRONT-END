//
//  Plate.swift
//  hollyfood
//
//  Created by Khairi on 30/11/2022.
//

import Foundation
import SwiftUI

struct Plate: Identifiable, Codable, Hashable {
    
    var id : String
    var name : String
    var category : String
    var price : Float
    var image : String
    var restaurant : String

    init(id: String,name: String, category: String, price: Float, image: String, restaurant: String) {
        
        self.id = id
        self.name = name
        self.category = category
        self.price = price
        self.image = image
        self.restaurant = restaurant
    }
    
    enum CodingKeys: String, CodingKey {
        
        case id = "_id"
        case name
        case category
        case price
        case image
        case restaurant
    }
}

struct  PlateDataModel:Codable{
    let plates:[Plate]
}

