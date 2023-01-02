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
    @AppStorage("language") var language: String = ""

    var body: some View {
        
        Form{
            Section(header: Text(language == "EN" ? "Edit Personal Information" : " تعديل المعلومات الشخصية")){
                
                NavigationLink(destination: EditProfile().navigationBarBackButtonHidden(false)) {
                    Image(systemName: "person.fill")
                    Text(language == "EN" ? "Edit Profile" : "تعديل الملف الشخصي")
                }.padding()
                
                NavigationLink(destination: ChangePassword().navigationBarBackButtonHidden(false)) {
                    Image(systemName: "lock.fill")
                    
                    Text(language == "EN" ? "Change Password" : "تغيير كلمة المرور")
                }.padding()
            }
            
            Section(header: Text(language == "EN" ? "Actions" : "إجراءات")){
                Toggle(language == "EN" ? "Dark Appearance" : "مظهر مظلم", isOn: $isDarkMode)
                    .toggleStyle(SwitchToggleStyle(tint: Color("PrimaryColor")))
                    .padding()
                
                Picker(language == "EN" ? "Language" : "اللغة", selection: $language){
                    ForEach(languages, id: \.self)
                    { language in
                        Text(language)
                    }
                }
                .padding()

            }
            

            
            Section(header: Text(language == "EN" ? "Sign Out" : "تسجيل الخروج")){
                
                NavigationLink(destination: Authentification().navigationBarBackButtonHidden(true)) {
                    Image(systemName: "rectangle.portrait.and.arrow.right")
                    Text(language == "EN" ? "Sign Out" : "تسجيل الخروج")
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

var languages = ["EN", "AR"]
