//
//  RestaurantViewModel.swift
//  hollyfood
//
//  Created by Khairi on 11/12/2022.
//

import Foundation
import Alamofire
import SwiftUI

class RestaurantViewModel: ObservableObject {
   
    var restaurant: Restaurant?

    func getRestaurant(id: String, onSuccess: @escaping() -> Void, onError: @escaping() -> Void) {
        
        AF.request(Statics.URL+"restaurant/"+id,
                   method: .get,
                   encoding: JSONEncoding.default)
        .validate(statusCode: 200..<300)
        .validate(contentType: ["application/json"])
        .responseJSON{
            response in
            switch response.result{
                
                case .success(let JSON):
                    
                    let response = JSON as! NSDictionary
                    
                    let id = response.object(forKey: "_id") as? String ?? ""
                    let name = response.object(forKey: "name") as? String ?? ""
                    let user = response.object(forKey: "user") as? String ?? ""

                    self.restaurant = Restaurant(id: id, name: name, user: user)
                    
                    onSuccess()
                    
                case .failure(let JSON):
                    print("failure")
                    onError()
                }
        }
        .responseJSON{(response) in print(response)}
    }

}

