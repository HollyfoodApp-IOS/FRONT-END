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
    var resetPasswordCode : String = ""
    
    static let sharedInstance = UserViewModel()
    
    func LogIn(email: String,password: String ,onSuccess: @escaping() -> Void, onError: @escaping() -> Void)   {
        
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
        AF.request(Statics.URL+"user",
                   method: .post,
                   parameters:parametres, encoding: JSONEncoding.default)
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
    
    func forgotPassword(email: String,onSuccess: @escaping() -> Void, onError: @escaping() -> Void)   {
        
            AF.request(Statics.URL+"user/forgotPassword" ,
                   method: .post,
                   parameters: [ "email" : email],encoding: URLEncoding.default)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData{
                
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
    
    func resetPasswordCodeVerification(code: String, onSuccess: @escaping() -> Void, onError: @escaping() -> Void)   {
        
            AF.request(Statics.URL+"user/resetPasswordCodeVerification" ,
                   method: .post,
                   parameters: [ "code" : code],encoding: URLEncoding.default)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData{
                
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
    
    func resetPassword(code: String, password:String, onSuccess: @escaping() -> Void, onError: @escaping() -> Void)   {
        
            AF.request(Statics.URL+"user/resetPassword" ,
                   method: .post,
                       parameters: [ "code" : code, "password" : password],encoding: URLEncoding.default)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData{
                
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




}

