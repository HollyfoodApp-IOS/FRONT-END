//
//  Settings.swift
//  hollyfood
//
//  Created by Khairi on 20/12/2022.
//

import SwiftUI

struct Settings: View {
    
    @State var type : String = "user"
    
    @AppStorage("isDarkMode") var isDarkMode: Bool = false

    var body: some View {
        
        Form{
            Section(header: Text("Edit Personal Information")){
                
                NavigationLink(destination: EditProfile().navigationBarBackButtonHidden(false)) {
                    Image(systemName: "person.fill")
                    Text("Edit Profile")
                }.padding()
                
                NavigationLink(destination: ChangePassword().navigationBarBackButtonHidden(false)) {
                    Image(systemName: "lock.fill")
                    
                    Text("Change Password")
                }.padding()
            }
            
            Section(header: Text("Actions")){
                Toggle("Dark Appearance", isOn: $isDarkMode)
                    .toggleStyle(SwitchToggleStyle(tint: Color("PrimaryColor")))
                    .padding()
            }
            
            Section(header: Text("Sign Out")){
                
                NavigationLink(destination: Authentification().navigationBarBackButtonHidden(true)) {
                    Image(systemName: "rectangle.portrait.and.arrow.right")
                    Text("Sign Out")
                }.padding()

            }
        }
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)
        .padding(.top, 55)
        
        /*
         List {
            
            /*
             Button(action: {
                isDarkMode.toggle()
            }, label: {
                
                HStack{
                    Image(systemName: isDarkMode ? "moon.circle.fill" : "moon.circle")
                        .imageScale(.large)

                    Text(isDarkMode ? "Switch To Light Mode" : "Switch To Dark Mode")
                        .foregroundColor(Color("DarkColor"))


                }
            }).padding()
             */

         /*
          NavigationLink(destination: OrderHistory(type: $type, id: $userID).navigationBarBackButtonHidden(false)) {
                Image(systemName: "bag.fill")
                Text("Order History")
            }.padding()
          */


        }
        .padding(.top, 55)
         */
        
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
