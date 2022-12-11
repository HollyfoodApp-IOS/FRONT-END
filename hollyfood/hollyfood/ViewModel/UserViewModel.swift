//
//  UserViewModel.swift
//  hollyfood
//
//  Created by Khairi on 16/11/2022.
//

import Foundation
import Alamofire

class UserViewModel: ObservableObject {
    
    var id : String = ""
    var fullname : String = ""
    var email : String = ""
    var password : String = ""
    var phone : String = ""
    var address : String = ""
    var role : String = ""
    var resetPasswordCode : String = ""
    var verificationCode : String = ""
    
    static var session: User?
    static let sharedInstance = UserViewModel()
    
    func LogIn(email: String,password: String , onSuccess: @escaping(_ message : String) -> Void)   {
        
            AF.request(Statics.URL+"user/login" ,
                   method: .post,
                   parameters: [ "email" : email, "password" : password ],
                   encoding: JSONEncoding.default)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseJSON{
                
                (response) in
                switch response.result{
                case .success(let JSON):
                    //print("Logged In \(JSON )")
                    let response = JSON as! NSDictionary
                    let message = response.object(forKey: "message") as? String ?? ""
                    if message == ""
                    {
                        let id = response.object(forKey: "_id") as? String ?? ""
                        let fullname = response.object(forKey: "fullname") as? String ?? ""
                        let email = response.object(forKey: "email") as? String ?? ""
                        let phone = response.object(forKey: "phone") as? String ?? ""
                        let role = response.object(forKey: "role") as? String ?? ""

                        //print(JSON)
                        print("USER LOGGED IN:")
                        print("ID is: \(id )")
                        print("Email is: \(email )")
                        print("Full Name is:   \(fullname )")
                        print("Phone is: \(phone )")
                        print("Role is: \(role )")

                        Self.session = User(id: id, fullname: fullname, email: email, password: "", phone: phone, address: "", role: role)
                    }

                    onSuccess(message)
                    
                case .failure(let JSON):
                    print(JSON)
                }
            }
    }
        
    func SignUp(user: User, onSuccess: @escaping() -> Void) {
        
        print(user)
        let parametres: [String: Any] = [
            "fullname": user.fullname,
            "email": user.email,
            "password": user.password,
            "phone": user.phone,
            "address": user.address,
            "role" : user.role
        ]
        AF.request(Statics.URL+"user/register",
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
    
    func verifyAccount(email: String, code:String, onSuccess: @escaping() -> Void, onError: @escaping() -> Void)   {
        
            AF.request(Statics.URL+"user/verifyAccount" ,
                       method: .post,
                       parameters: [ "email" : email, "code" : code],encoding: URLEncoding.default)
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

    func editProfile(id: String, fullname: String, email:String, phone:String, onSuccess: @escaping(_ message : String) -> Void)   {
        
            AF.request(Statics.URL+"user/"+id,
                       method: .patch,
                       parameters: ["fullname" : fullname, "email" : email ,"phone" : phone],encoding: JSONEncoding.default)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseJSON{
                response in
                switch response.result{
                case .success(let JSON):
                    
                    let response = JSON as! NSDictionary
                    let message = response.object(forKey: "message") as? String ?? ""
                    
                    if message == ""
                    {
                        let id = response.object(forKey: "_id") as? String ?? ""
                        let fullname = response.object(forKey: "fullname") as? String ?? ""
                        let email = response.object(forKey: "email") as? String ?? ""
                        let phone = response.object(forKey: "phone") as? String ?? ""
                        let role = response.object(forKey: "role") as? String ?? ""

                        //print(JSON)
                        print(" ")
                        print("USER UPDATED IN:")
                        print("ID is: \(id )")
                        print("Email is: \(email )")
                        print("Full Name is:   \(fullname )")
                        print("Phone is: \(phone )")
                        print("Role is: \(role )")
                        
                        Self.session = User(id: id, fullname: fullname, email: email, password: "", phone: phone, address: "", role: role)


                    }
                    onSuccess(message)
                    
                case .failure(let JSON):
                    print("failure")

                }
            }
            .responseJSON{(response) in print(response)}
    }

    func changePassword(email: String, oldPassword:String, newPassword:String, onSuccess: @escaping(_ message : String) -> Void, onError: @escaping() -> Void)   {
        
            AF.request(Statics.URL+"user/changePassword",
                       method: .post,
                       parameters: ["email" : email, "oldPassword" : oldPassword ,"newPassword" : newPassword],
                       encoding: JSONEncoding.default)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseJSON{
                response in
                switch response.result{
                case .success(let JSON):
                    
                    let response = JSON as! NSDictionary
                    let message = response.object(forKey: "message") as? String ?? ""
                    
                    onSuccess(message)
                    
                case .failure(let JSON):
                    print("failure")
                    onError()
                }
            }
            .responseJSON{(response) in print(response)}
    }
    
    func getUser(id: String, onSuccess: @escaping(_ us : User) -> Void){
        
        //print(order)
        
        AF.request(Statics.URL+"user/"+id,
                   method: .get,
                   encoding: JSONEncoding.default)
        .validate(statusCode: 200..<300)
        .validate(contentType: ["application/json"])
        .responseJSON {
            response in
            switch response.result {
            case .success(let JSON):

                let response = JSON as! NSDictionary

                let id = response.object(forKey: "_id") as? String ?? ""
                let fullname = response.object(forKey: "fullname") as? String ?? ""
                let email = response.object(forKey: "email") as? String ?? ""
                let phone = response.object(forKey: "phone") as? String ?? ""
                let role = response.object(forKey: "role") as? String ?? ""

                //print(JSON)
                let user = User(id: id, fullname: fullname, email: email, password: "", phone: phone, address: "", role: role)
                
                print("fullname is: "+user.fullname)

                onSuccess(user)
                
                return
                
            case .failure:
                print("Delete Order Failed")
                
            }
        }
    }



}

