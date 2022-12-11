//
//  Restaurant.swift
//  hollyfood
//
//  Created by Khairi on 9/12/2022.
//

import Foundation

struct Restaurant: Identifiable, Codable, Hashable {
    
    var id : String
    var name : String
    var user : String
    
    init(id: String,name: String, user: String) {
        
        self.id = id
        self.name = name
        self.user = user
    }
    
    enum CodingKeys: String, CodingKey {
        
        case id = "_id"
        case name
        case user
    }
}

struct  RestaurantDataModel:Codable{
    let restaurants:[Restaurant]
}
