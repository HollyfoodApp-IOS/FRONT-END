//
//  CommentModel.swift
//  hollyfood
//
//  Created by AlaBenRejab on 1/1/2023.
//

import Foundation

struct Comment: Codable {
    let id, date, CommentText, author: String
   // let restuarant :RestaurantElement
    
    internal init(id: String ,date: String, CommentText: String,author: String) {
        self.id = id
        self.date = date
        self.CommentText = CommentText
        self.author = author
       // self.restuarant=restaurant
        //self.utilisateur = utilisateur
    }

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case date
        case CommentText = "description"
        case author
       // case restaurant
    }
}
