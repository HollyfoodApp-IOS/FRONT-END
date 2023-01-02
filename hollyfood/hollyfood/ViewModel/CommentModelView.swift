//
//  CommentModelView.swift
//  hollyfood
//
//  Created by AlaBenRejab on 1/1/2023.
//

import Alamofire
import UIKit.UIImage

class CommentViewModel: ObservableObject {
    @Published var commentaire = [Comment]()

    @Published var commentaires = [Comment]()
    var author:String=""
    var description:String=""
    
    static let sharedInstance = CommentViewModel()
    let prefix = Statics.URL

    

    func getAllComments(id:String){
        print(id)
        guard let url = URL(string: "\(prefix)/Comment/\(id)") else {
            print("not found")
            return
        }
        
        URLSession.shared.dataTask(with: url) {
            (data , res , error) in
            if error != nil
            {
                print ("error", error?.localizedDescription ?? "")
                print("aaz")
                return
            }
            do {
                if let data = data {
                    let result = try JSONDecoder().decode([Comment].self, from: data)
                    DispatchQueue.main.async {
                        self.commentaires = result
                        print(self.commentaires)
                        
                        print("aee")
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
    func getComments(){
        let defaults=UserDefaults.standard
        let id = defaults.object(forKey: "id")!
        let parameters: [String: Any] = [
            "idRestaurant": id]
        guard let url = URL(string: "\(prefix)/Comment/") else {
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
                    let result = try JSONDecoder().decode([Comment].self, from: data)
                    DispatchQueue.main.async {
                        self.commentaires = result
                        print("data:" ,self.commentaires)
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
    func AddComment(idRestaurant: String,description: String,author:String) {
        print(description)
        let parameters: [String: Any] = [
            "author": author,
            "description": description
        ]
        guard let url = URL(string: "\(prefix)/Comment/Add/\(idRestaurant)") else {
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
                    let result = try JSONDecoder().decode(Comment.self, from: data)
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
    
    func ajouterCommentaire(idRestaurant: String, commentaire: Comment, completed: @escaping (Bool) -> Void ) {
        AF.request(prefix + "Comment/Add",
                   method: .post,
                   parameters: [
                    "description": commentaire.CommentText,
                    "date": commentaire.date,
                    "restaurant": idRestaurant,
                    //"utilisateur": UserDefaults.standard.string(forKey: "idUtilisateur")!
                   ], encoding: JSONEncoding.default)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    completed(true)
                case let .failure(error):
                    debugPrint(error)
                    completed(false)
                }
            }
    }
    
    func modifierCommentaire(comment: Comment, completed: @escaping (Bool) -> Void ) {
        AF.request(prefix + "Comment/Add",
                   method: .put,
                   parameters: [
                    "_id": comment.id,
                    "description": comment.CommentText
                   ], encoding: JSONEncoding.default)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    completed(true)
                case let .failure(error):
                    debugPrint(error)
                    completed(false)
                }
            }
    }
    
    func supprimerCommentaire(_id: String?, completed: @escaping (Bool) -> Void ) {
        AF.request(prefix + "Comment/Delete",
                   method: .delete,
                   parameters: [
                    "_id": _id!
                    
                   ], encoding: JSONEncoding.default)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    completed(true)
                case let .failure(error):
                    debugPrint(error)
                    completed(false)
                }
            }
    }
    
   
    /*func makeUtilisateur(jsonItem: JSON) -> Utilisateur {
        return Utilisateur(
            _id: jsonItem["_id"].stringValue,
            pseudo: jsonItem["pseudo"].stringValue,
            email: jsonItem["email"].stringValue,
            mdp: jsonItem["mdp"].stringValue,
            nom: jsonItem["nom"].stringValue,
            prenom: jsonItem["prenom"].stringValue,
            dateNaissance: Date(),
            idPhoto: jsonItem["idPhoto"].stringValue,
            sexe: jsonItem["sexe"].boolValue,
            score: jsonItem["score"].intValue,
            bio: jsonItem["bio"].stringValue,
            isVerified: jsonItem["isVerified"].boolValue
        )
    }*/
    
 
}
