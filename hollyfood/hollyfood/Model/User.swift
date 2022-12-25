//
//  User.swift
//  hollyfood
//
//  Created by Khairi on 16/11/2022.
//

import Foundation

struct User {
    
    var id : String
    var fullname : String
    var email : String
    var password : String
    var phone : String
    var role : String
 
    init(id: String, fullname: String, email: String, password: String, phone: String, role: String) {
        
        self.id = id
        self.fullname = fullname
        self.email = email
        self.password = password
        self.phone = phone
        self.role = role
    }
}

struct UserDataModel: Decodable {
    
    var id : String
    var fullname : String
    var email : String
    var password : String
    var phone : String
    var role : String
    
    enum CodingKeys: String, CodingKey {
        
        case id
        case fullname
        case email
        case password
        case phone
        case role
    }
}
