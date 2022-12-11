//
//  OrderlineViewModel.swift
//  hollyfood
//
//  Created by Khairi on 5/12/2022.
//

import Foundation
import Alamofire

class OrderlineViewModel: ObservableObject {
    
    @Published var orderlines = [Orderline]()

    func addOrderline(orderline: Orderline) {
        
        print(orderline)
        
        let parametres: [String: Any] = [
            "plate": orderline.plate,
            "quantity": orderline.quantity,
            "price": orderline.price,
            "order": orderline.order,
            "plateName": orderline.plateName,
            "plateCategory": orderline.plateCategory,
            "plateImage": orderline.plateImage,
            "offset": orderline.offset,
            "isSwiped": orderline.isSwiped
        ]
        
        AF.request(Statics.URL+"orderline",
                   method: .post,
                   parameters:parametres, encoding: JSONEncoding.default)
        .validate(statusCode: 200..<300)
        .validate(contentType: ["application/json"])
        .responseData {
            response in
            switch response.result {
            case .success:
                print("success")
                
            case let .failure(error):
                print(error)
                
            }
        }
    }
    
    func getOrderlinesByOrder(order: String){
        
        guard let url = URL(string: Statics.URL+"orderline/getOrderlinesByOrder/"+order) else {
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
                    let result = try JSONDecoder().decode([Orderline].self, from: data)
                    DispatchQueue.main.async {
                        
                        self.orderlines = result
                        
                        print(" ")
                        print("=== Orderlines=== ")
                        print(self.orderlines)
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
