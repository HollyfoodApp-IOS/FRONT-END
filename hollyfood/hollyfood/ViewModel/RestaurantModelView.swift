//
//  RestaurantModelView.swift
//  hollyfood
//
//  Created by AlaBenRejab on 1/1/2023.
//

import Foundation

class RestaurantModelView: ObservableObject{
    
    @Published var restaurants = [RestaurantElement]()
    @Published var restaurant = [RestaurantElement]()
    let prefix = Statics.URL
    var name:String=""
    var Adresse:String=""
    var description:String=""
    var photo:String=""
    var phone_number:String=""
    var totalrating:String="0"
    var user:String=""

    func getAllRestrauants(){
        print("a")
        guard let url = URL(string: "\(Statics.URL)restaurant/") else {
            
            return print("not found")
        }
        
        URLSession.shared.dataTask(with: url) {
            (data , res , error) in
            if error != nil
            {
                print ("error", error?.localizedDescription ?? "")
                return
            }
            do {
                if let data = data {
                    let result = try JSONDecoder().decode([RestaurantElement].self, from: data)
                    DispatchQueue.main.async {
                        self.restaurants = result
                        print(self.restaurants)
                        
                    }
                    
                }
                else {
                    print ("no data")
                }
            } catch let JsonError {
                
                 print("fetch json error :", JsonError.localizedDescription)
                print(String(describing: JsonError))
                
            }
        }.resume()
    }
    
    func getRestrauant(){
        let defaults=UserDefaults.standard
        let id = defaults.object(forKey: "id")
        guard let url = URL(string: "\(Statics.URL)/restaurant/\(id)") else {
            print("not found")
            return
        }
        
        URLSession.shared.dataTask(with: url) {
            (data , res , error) in
            if error != nil
            {
                print ("error", error?.localizedDescription ?? "")
                return
            }
            do {
                if let data = data {
                    let result = try JSONDecoder().decode([RestaurantElement].self, from: data)
                    DispatchQueue.main.async {
                        self.restaurant = result
                        print("data:" ,self.restaurants)
                    }
                }
                else {
                    print ("no data")
                }
            } catch let JsonError {
                
                //  print("fetch json error :", JsonError.localizedDescription)
                String(describing: JsonError)
                
            }
        }.resume()
        
    }
    
    func AddRestaurant(restaurant: RestaurantElement,onSuccess: @escaping() -> Void) {
        print(restaurant)
        let parameters: [String: Any] = [
            "name": restaurant.name,
            "Adresse": restaurant.Adresse,
            "phone_number": restaurant.phone_number,
            "photo": restaurant.photo,
            "description": restaurant.description,
            "user": restaurant.user
        ]
        guard let url = URL(string: "\(Statics.URL)/restaurant/addRestaurant/") else {
            print("not found")
            print("not found")
            return
        }
        let data = try! JSONSerialization.data(withJSONObject: parameters)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = data
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        URLSession.shared.dataTask(with: request) {
            (data , res , error) in
            if error != nil
            {
                print ("error", error?.localizedDescription ?? "")
                return
            }
            do {
                if let data = data {
                    let result = try JSONDecoder().decode(RestaurantElement.self, from: data)
                    DispatchQueue.main.async {
                        print(result)
                    }
                    
                }
                else {
                    print ("no data")
                }
            } catch let JsonError {
                
                print("fetch json error :", JsonError.localizedDescription)
                print(String(describing: JsonError))
                
            }
        }.resume()
    }
    
    func updateRestrauants(restaurant: RestaurantElement){
        let defaults = UserDefaults.standard
        let id = defaults.object(forKey: "id")!
        let parameters: [String: Any] = [
            "name": restaurant.name,
            "Adresse": restaurant.Adresse,
            "phone_number": restaurant.phone_number,
            "photo": restaurant.photo,
            "description": restaurant.description,
            "user": restaurant.user

        ]
        
        guard let url = URL(string: "\(prefix)/restaurant/update/\(id)") else {
            print("not found")
            return
        }
        let data = try! JSONSerialization.data(withJSONObject: restaurant)
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.httpBody = data
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        URLSession.shared.uploadTask(with: request, from: data) {
            (data , res , error) in
            if error != nil
            {
                print ("error", error?.localizedDescription ?? "")
                return
            }
            do {
                if let data = data {
                    let result = try JSONDecoder().decode(RestaurantElement.self, from: data)
                    DispatchQueue.main.async {
                        print(result)
                    }
                    
                }
                else {
                    print ("no data")
                }
            } catch let JsonError {
                
                //  print("fetch json error :", JsonError.localizedDescription)
                print(String(describing: JsonError))
                
            }
        }.resume()
        
        
    }
    
    func getRestrauantNearMe(long:String,lat:String){
        guard let url = URL(string: "\(prefix)/restaurant/find/\(lat)/\(long)") else {
            print("not found")
            return
        }
        
        URLSession.shared.dataTask(with: url) {
            (data , res , error) in
            if error != nil
            {
                print ("error", error?.localizedDescription ?? "")
                return
            }
            do {
                if let data = data {
                    let result = try JSONDecoder().decode([RestaurantElement].self, from: data)
                    DispatchQueue.main.async {
                        self.restaurant = result
                        print("data:" ,self.restaurants)
                    }
                    
                }
                else {
                    print ("no data")
                }
            } catch let JsonError {
                
                //  print("fetch json error :", JsonError.localizedDescription)
                String(describing: JsonError)
                
            }
        }.resume()
        
        
    }
    
    func getMyRestrauants(user:String){
        print("a")
        guard let url = URL(string: "\(Statics.URL)restaurant/user/"+user) else {
            
            return print("not found")
        }
        
        URLSession.shared.dataTask(with: url) {
            (data , res , error) in
            if error != nil
            {
                print ("error", error?.localizedDescription ?? "")
                return
            }
            do {
                if let data = data {
                    let result = try JSONDecoder().decode([RestaurantElement].self, from: data)
                    DispatchQueue.main.async {
                        self.restaurants = result
                        print(self.restaurants)
                        
                    }
                    
                }
                else {
                    print ("no data")
                }
            } catch let JsonError {
                
                 print("fetch json error :", JsonError.localizedDescription)
                print(String(describing: JsonError))
                
            }
        }.resume()
    }
 
}
