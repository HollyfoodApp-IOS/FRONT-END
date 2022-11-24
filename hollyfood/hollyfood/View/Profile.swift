//
//  Profile.swift
//  hollyfood
//
//  Created by Khairi on 18/11/2022./Users/khairi/Desktop/FRONT-END/hollyfood/hollyfood.xcodeproj
//

import SwiftUI

struct Profile: View {

    var body: some View {
        
        NavigationView {
            List {
                HStack(spacing: 10){
                    
                    Button(action: {}) {
                        Image(systemName: "square.and.pencil")
                            .font(.system(size: 26))
                            .foregroundColor(Color("Color"))
                    }

                    Text("Username")
                        .font(.system(size: 25))
                        .foregroundColor(Color("Color"))
                    
                    NavigationLink(destination: EditProfile().navigationBarBackButtonHidden(false)){
                        
                    }

                    
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 8).stroke(Color("Color"), lineWidth: 1))

                NavigationLink(destination: Text("My Address")) {
                    Image(systemName: "location.viewfinder")
                    Text("My Address")
                }.padding()

                NavigationLink(destination: Text("Sign Out")) {
                    Image(systemName: "rectangle.portrait.and.arrow.right")
                    Text("Sign Out")
                }.padding()

                .navigationTitle("Account")
            }
        }

    }
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        Profile()
    }
}

