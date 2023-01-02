//
//  Orderline.swift
//  hollyfood
//
//  Created by Khairi on 5/12/2022.
//

import Foundation
import SwiftUI

struct Orderline: Identifiable, Codable, Hashable {
    
    var id : String
    var quantity : Int
    var price : Float
    var plate : String
    var order : String
    var plateName : String
    
    var plateCategory : String
    var plateImage : String
    var offset: CGFloat
    var isSwiped: Bool

    init(id: String, quantity: Int, price: Float, plate: String, order: String, plateName : String, plateCategory : String, plateImage : String, offset : CGFloat, isSwiped : Bool) {
        
        self.id = id
        self.quantity = quantity
        self.price = price
        self.plate = plate
        self.order = order
    
        self.plateName = plateName
        self.plateCategory = plateCategory
        self.plateImage = plateImage
        self.offset = offset
        self.isSwiped = isSwiped

    }
    
    enum CodingKeys: String, CodingKey {
        
        case id = "_id"
        case quantity
        case price
        case plate
        case order
        case plateName
        case plateCategory
        case plateImage
        case offset
        case isSwiped 

    }
}

struct  OrderlineDataModel:Codable{
    let orderlines:[Orderline]
}
