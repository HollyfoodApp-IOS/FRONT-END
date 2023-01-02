//
//  ViewController.swift
//  hollyfood
//
//  Created by Khairi on 12/12/2022.
//

import UIKit
import GoogleSignIn
import Alamofire

class ViewController: UIViewController {
    
    let signInConfig = GIDConfiguration(clientID: "185174827966-ab4gm3hb6onf2bmj7i01cdk450sbuqi6.apps.googleusercontent.com")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    /*func SignUp(user: User) {
            print(user)
            let parametres: [String: Any] = [
                "first_name": user.firstName,
                "last_name": user.lastName,
                "email": user.email,
                "password": user.password,
                
            ]
            AF.request(Statics.URL+"/user/compte" , method: .post,parameters:parametres ,encoding: JSONEncoding.default)
                .validate(statusCode: 200..<500)
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
            
        }*/

    
    @IBAction func googleLogin(_ sender: Any) {
        GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: self) { user, error in
            guard error == nil else { return }
            guard let user = user else { return }

            let emailAddress = user.profile?.email
            let fullName = user.profile?.name
            let givenName = user.profile?.givenName
            let familyName = user.profile?.familyName
            print(emailAddress,fullName,givenName)
            
            
        }
        
    }
    
}
