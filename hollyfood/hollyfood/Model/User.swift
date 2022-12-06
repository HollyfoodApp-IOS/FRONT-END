//
//  User.swift
//  hollyfood
//
//  Created by Khairi on 16/11/2022.
//

import Foundation

struct User {
    
    var fullname : String
    var email : String
    var password : String
    var phone : String
    var address : String
    var role : String
 
    init(fullname: String, email: String, password: String, phone: String, address: String, role: String) {
        
        self.fullname = fullname
        self.email = email
        self.password = password
        self.phone = phone
        self.address = address
        self.role = role
    }
}

struct UserDataModel: Decodable {
    
    var fullname : String
    var email : String
    var password : String
    var phone : String
    var address : String
    var role : String
    
    enum CodingKeys: String, CodingKey {
        
        case fullname
        case email
        case password
        case phone
        case address
        case role
    }
}
