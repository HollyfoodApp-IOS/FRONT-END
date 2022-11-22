//
//  UserViewModel.swift
//  hollyfood
//
//  Created by Khairi on 16/11/2022.
//

import Foundation
import Alamofire

class UserViewModel: ObservableObject {
    
    var fullname : String = ""
    var email : String = ""
    var password : String = ""
    var phone : String = ""
    var address : String = ""
    var role : String = ""
    
    static let sharedInstance = UserViewModel()
    
    func LogIn(email: String,password: String ,onSuccess: @escaping() -> Void, onError: @escaping() -> Void)   {
        
        
        // print("login with success")
        AF.request(Statics.URL+"user/login" ,
                   method: .post,
                   parameters: [ "email" : email, "password" : password ],encoding: URLEncoding.default).validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"]).responseData{
                
                response in
                switch response.result{
                case.success:
                    onSuccess()
                                    
                    
                case .failure:
                    onError()
                }
            }
            .responseJSON{(response) in print(response)}
    }
        
    func SignUp(user: User,onSuccess: @escaping() -> Void) {
        
        print(user)
        let parametres: [String: Any] = [
            "fullname": user.fullname,
            "email": user.email,
            "password": user.password,
            "phone": user.phone,
            "address": user.address,
            "role" : user.role
        ]
        AF.request(Statics.URL+"user", method: .post, parameters:parametres, encoding: JSONEncoding.default)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData {
                response in
                switch response.result {
                case .success:
                    onSuccess()
                    
                case let .failure(error):
                    print(error)
                        
                    
                }
            }
    }

}

