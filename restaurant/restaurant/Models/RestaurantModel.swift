//
//  RestaurantModel.swift
//  restaurant
//
//  Created by Mac Mini 9 on 18/11/2022.
//

import Foundation

struct Restaurant{
    
    var name :String
    var Adress : String
    var phone_number : String
    var photo : String
    var description : String
   // var reviews :
    //var commentaire :
    var rating : String
    
    init(name: String, Adress: String, phone_number: String, photo: String, description: String, rating: String) {
        self.name = name
        self.Adress = Adress
        self.phone_number = phone_number
        self.photo = photo
        self.description = description
        self.rating = rating
    }
        
}
