//
//  RestaurantModelView.swift
//  restaurant
//
//  Created by Mac Mini 9 on 18/11/2022.
//
import Foundation



class RestaurantModelView: ObservableObject{
    var name : String = ""
    var Adress : String = ""
    var phone_number : String = ""
    var photo : String = ""
    var description : String = ""
    var rating  : String = "0"
    
    static let  sharedInstance = RestaurantModelView()
    
   func AddRestaurant(restaurant : Restaurant, onSuccess: @escaping() -> Void){
        print (restaurant)
        let parametres: [String: Any] = [
            "name" : restaurant.name,
            "Adress" : restaurant.Adress,
            "phone_number" : restaurant.phone_number,
            "photo" : restaurant.photo,
            "description" : restaurant.description,
            "rating" : restaurant.rating
        ]
       /* AF.request(Statics.URL+"restaurant", method : .post, parammeters:parametres, enocoding : JSONEncoding.default)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData{
                reponse in
                switch response.result{
                case .success :
                    print("Success")
                    onSuccess()
                case let.failure(error):
                    print(error)
                    
                }
            }*/
    }
}
