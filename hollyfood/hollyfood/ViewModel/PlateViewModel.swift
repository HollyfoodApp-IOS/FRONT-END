//
//  PlateViewModel.swift
//  hollyfood
//
//  Created by Khairi on 3/12/2022.
//

import Foundation
import Alamofire
import SwiftUI

class PlateViewModel: ObservableObject {
    
    @Published var plates = [Plate]()
    var restaurantMenu : String = ""

    var plate: Plate?
    
    var id : String = ""
    var name : String = ""
    var category : String = ""
    var price : String = ""
    var image : String = ""
    var restaurant : String = ""

    
    func addPlate(plate: Plate, onSuccess: @escaping() -> Void, onError: @escaping() -> Void) {
        
        print(plate)
        let parametres: [String: Any] = [
            "name": plate.name,
            "category": plate.category,
            "price": plate.price,
            "image": plate.image,
            "restaurant": plate.restaurant,
        ]
        
        AF.request(Statics.URL+"plate",
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
                onError()
                print(error)
                
            }
        }
    }
                
    func getPlatesByRestaurant(restaurant: String, category: String){
        
        guard let url = URL(string: Statics.URL+"plate/getPlatesByRestaurant/"+restaurant) else {
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
                    let result = try JSONDecoder().decode([Plate].self, from: data)
                    DispatchQueue.main.async {
                        self.plates = result
                        
                        if category != "All"
                        {
                            for plate in self.plates {
                                
                                if plate.category != category
                                {
                                    let index = self.plates.firstIndex(of: plate)
                                    self.plates.remove(at: index!)
                                }
                            }
                        }
                        //print(self.plates)
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
    
    func getPlate(id: String, onSuccess: @escaping() -> Void, onError: @escaping() -> Void) {
        
        AF.request(Statics.URL+"plate/"+id,
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
                let category = response.object(forKey: "category") as? String ?? ""
                let price = response.object(forKey: "price") as? Float ?? 0
                let image = response.object(forKey: "image") as? String ?? ""
                let restaurant = response.object(forKey: "restaurant") as? String ?? ""
                
                self.plate = Plate(id: id, name: name, category: category, price: price, image: image, restaurant: restaurant)
                
                onSuccess()
                
            case .failure(let JSON):
                print("failure")
                onError()
            }
        }
        .responseJSON{(response) in print(response)}
    }
        
    func editPlate(plate: Plate, onSuccess: @escaping() -> Void) {
        
        //print(plate)
        let parametres: [String: Any] = [
            "name": plate.name,
            "category": plate.category,
            "price": plate.price,
            "image": plate.image,
            "restaurant": plate.restaurant,
        ]
        
        AF.request(Statics.URL+"plate/"+plate.id,
                   method: .patch,
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

    func deletePlate(id: String, onSuccess: @escaping() -> Void) {
        
        AF.request(Statics.URL+"plate/"+id,
                   method: .delete,
                   encoding: JSONEncoding.default)
        .validate(statusCode: 200..<300)
        .validate(contentType: ["application/json"])
        .responseJSON {
            response in
            switch response.result {
            case .success:
                print("Plate Deleted")
                onSuccess()
                
            case .failure:
                print("Delete Plate Failed")
                
            }
        }
    }

}
