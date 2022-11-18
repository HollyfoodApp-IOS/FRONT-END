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
    
    func LogIn(email: String,password: String ,onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        
        AF.request(Statics.URL+"user/login" , method: .post, parameters: ["email": email,"password": password] ,encoding: JSONEncoding.default)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseJSON {
                (response) in
                switch response.result {
                case .success(let JSON):
                    print("success \(JSON)")
                    onSuccess()
                    
                case .failure(let error):
                    //print("request failed \(error)")
                    onError(error.localizedDescription)
                    
                    //response in debugPrint(response)
                    if error != nil {
                        onError(error.localizedDescription)
                        return
                        
                    }                }
            }
        //print("email : ",email)
        //print("password",password)
        
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
                    print("success")
                    onSuccess()
                case let .failure(error):
                    print(error)
                    
                }
            }
    }

}
