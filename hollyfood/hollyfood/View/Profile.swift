//
//  Profile.swift
//  hollyfood
//
//  Created by Khairi on 18/11/2022./Users/khairi/Desktop/FRONT-END/hollyfood/hollyfood.xcodeproj
//

import SwiftUI

struct Profile: View {
        
    @State var type : String = "user"

    var body: some View {
        
        List {
            
            NavigationLink(destination: EditProfile().navigationBarBackButtonHidden(false)) {
                Image(systemName: "person.fill")
                    .foregroundColor(Color("PrimaryColor"))
                Text("Edit Profile")
                    .foregroundColor(Color("PrimaryColor"))
            }.padding()
            
            NavigationLink(destination: ChangePassword().navigationBarBackButtonHidden(false)) {
                Image(systemName: "lock.fill")
                Text("Change Password")
            }.padding()
            
            
            /*NavigationLink(destination: OrderHistory(type: $type, id: $userID).navigationBarBackButtonHidden(false)) {
                Image(systemName: "bag.fill")
                Text("Order History")
            }.padding()*/

            NavigationLink(destination: Authentification().navigationBarBackButtonHidden(true)) {
                Image(systemName: "rectangle.portrait.and.arrow.right")
                Text("Sign Out")
            }.padding()

        }
        .padding(.top, 55)
        
    }
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        Profile()
    }
}

