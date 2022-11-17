//
//  UserViewModel.swift
//  hollyfood
//
//  Created by Khairi on 16/11/2022.
//

import Foundation

class UserViewModel: ObservableObject {
    
    var fullname : String = ""
    var email : String = ""
    var password : String = ""
    var phone : String = ""
    var address : String = ""
    var role : String = ""
    
    static let sharedInstance = UserViewModel()
}
