//
//  RatingModel.swift
//  hollyfood
//
//  Created by AlaBenRejab on 1/1/2023.
//

import Foundation
struct RatingUserProduct: Codable


{
    internal init(_id: String? = nil, creator: String? = nil, restaurant: String? = nil,rating: Int? = nil) {
        self._id = _id
        self.creator = creator
        self.restaurant = restaurant
        self.rating = rating
        
        
        
        
    }
    
    var _id :String?
    var creator :String?
    var restaurant :String?
    var rating :Int?
    
}
