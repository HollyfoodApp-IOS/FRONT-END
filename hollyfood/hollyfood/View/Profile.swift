//
//  Profile.swift
//  hollyfood
//
//  Created by Khairi on 18/11/2022./Users/khairi/Desktop/FRONT-END/hollyfood/hollyfood.xcodeproj
//

import SwiftUI

struct Profile: View {
        
    var body: some View {
        
            List {
                
                NavigationLink(destination: EditProfile().navigationBarBackButtonHidden(false)) {
                    Image(systemName: "person.fill")
                        .foregroundColor(Color("Color"))
                    Text("Edit Profile")
                        .foregroundColor(Color("Color"))
                }.padding()
                
                NavigationLink(destination: ChangePassword().navigationBarBackButtonHidden(false)) {
                    Image(systemName: "lock.fill")
                    Text("Change Password")
                }.padding()
                
                NavigationLink(destination: Text("My Address")) {
                    Image(systemName: "location.viewfinder")
                    Text("My Address")
                }.padding()

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

