//
//  OrderViewModel.swift
//  hollyfood
//
//  Created by Khairi on 7/12/2022.
//

import Foundation
import Alamofire

class OrderViewModel: ObservableObject {
    
    @Published var orders = [Order]()

    func addOrder(order: Order, onSuccess: @escaping(_ orderId : String) -> Void) {
        
        print(order)
        
        let parametres: [String: Any] = [
            "price": order.price,
            "user": order.user,
            "restaurant": order.restaurant
        ]
        
        AF.request(Statics.URL+"order",
                   method: .post,
                   parameters:parametres, encoding: JSONEncoding.default)
        .validate(statusCode: 200..<300)
        .validate(contentType: ["application/json"])
        .responseJSON {
            response in
            switch response.result {
            case .success(let JSON):
                
                let response = JSON as! NSDictionary
                let orderlineJSON = response.object(forKey: "docs") as! NSDictionary

                let orderId = orderlineJSON.object(forKey: "_id") as? String ?? ""
                print("ORDER ID VIEW MODEL== "+orderId)

                onSuccess(orderId)
                
            case let .failure(error):
                print(error)
                
            }
        }
    }
    
    func getOrders(type: String, id:String){
        
        var req : String = ""
        
        if type == "user"
        {
            req = "order/getOrdersByUser/"+id
        }
        else
        {
            req = "order/getOrdersByRestaurant/"+id

        }
        
        guard let url = URL(string: Statics.URL+req) else {
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
                    let result = try JSONDecoder().decode([Order].self, from: data)
                    DispatchQueue.main.async {
                        self.orders = result
                        //print(self.orders)
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
    
    func deleteOrder(id: String, onSuccess: @escaping() -> Void) {
        
        //print(order)
        
        AF.request(Statics.URL+"order/"+id,
                   method: .delete,
                   encoding: JSONEncoding.default)
        .validate(statusCode: 200..<300)
        .validate(contentType: ["application/json"])
        .responseJSON {
            response in
            switch response.result {
            case .success:
                print("Order Deleted")
                onSuccess()
                
            case .failure:
                print("Delete Order Failed")
                
            }
        }
    }

    
}
