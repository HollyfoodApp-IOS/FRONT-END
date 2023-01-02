//
//  ChangePassword.swift
//  hollyfood
//
//  Created by Khairi on 27/11/2022.
//

import SwiftUI

struct ChangePassword: View {
    
    
    var body: some View {
        ChangePassword_Code()
    }
}

struct ChangePassword_Previews: PreviewProvider {
    static var previews: some View {
        ChangePassword()
    }
}

struct ChangePassword_Code: View {
    
    @ObservedObject var viewModel = UserViewModel()
    @State var alert = false
    @State var title = ""
    @State var message = ""

    @State var email:String = UserViewModel.session?.email ?? ""
    @State var oldPassword:String = ""
    @State var newPassword:String = ""
    @State var confirmPassword:String = ""
    
    @State var visible = false
    @State var visible2 = false
    @State var visible3 = false

    @State var color = Color("DarkColor").opacity(0.7)
    
    @ObservedObject var translation = Translation()
    @State var Old_Password : String = ""
    @State var Enter_Old_Password : String = ""
    @State var New_Password : String = ""
    @State var Enter_New_Password : String = ""
    @State var Conifrm_Password : String = ""
    @State var Repeat_New_Password : String = ""
    @State var Error : String = ""
    @State var Message : String = ""
    @State var Wrong_password : String = ""
    @State var Password_changed_successfully : String = ""
    @State var Change_Password : String = ""
    @State var confirmPasswordVerification : String = ""
    @State var fieldsEmptyMessage : String = ""

    
    var body: some View {
        ZStack{
            
            ZStack(alignment: .topTrailing) {
                
                VStack{
                    
                        GeometryReader{_ in
                                
                                VStack{
                                    
                                    VStack(alignment: .leading, spacing: 10){
                                        

                                        Text(Old_Password)
                                            .font(.system(size: 18))
                                            .fontWeight(.bold)
                                            .foregroundColor(Color("GrayColor"))
                                            .padding(.top, 30)
                                        
                                        HStack(spacing: 15){
                                            
                                            VStack{
                                                
                                                if self.visible{
                                                    
                                                    TextField(Enter_Old_Password, text: $oldPassword)
                                                        .autocapitalization(.none)
                                                }
                                                else{
                                                    
                                                    SecureField(Enter_Old_Password, text: $oldPassword)
                                                        .autocapitalization(.none)
                                                }
                                            }
                                            
                                            Button(action: {
                                                
                                                self.visible.toggle()
                                                
                                            }) {
                                                
                                                Image(systemName: self.visible ? "eye.slash.fill" : "eye.fill")
                                                    .foregroundColor(self.color)
                                            }
                                            
                                        }
                                        .padding()
                                        .background(Color("LightColor"))
                                        .cornerRadius(5)
                                        .shadow(color: Color("DarkColor").opacity(0.1), radius: 5, x: 0, y: 5)
                                        .shadow(color: Color("DarkColor").opacity(0.08), radius: 5, x: 0, y: -5)
                                        .font(.system(size: 20))
                                        
                                        
                                        Text(New_Password)
                                            .font(.system(size: 18))
                                            .fontWeight(.bold)
                                            .foregroundColor(Color("GrayColor"))
                                            .padding(.top, 10)
                                        
                                        HStack(spacing: 15){
                                            
                                            VStack{
                                                
                                                if self.visible2{
                                                    
                                                    TextField(Enter_New_Password, text: $newPassword)
                                                        .autocapitalization(.none)
                                                }
                                                else{
                                                    
                                                    SecureField(Enter_New_Password, text: $newPassword)
                                                        .autocapitalization(.none)
                                                }
                                            }
                                            
                                            Button(action: {
                                                
                                                self.visible2.toggle()
                                                
                                            }) {
                                                
                                                Image(systemName: self.visible2 ? "eye.slash.fill" : "eye.fill")
                                                    .foregroundColor(self.color)
                                            }
                                            
                                        }
                                        .padding()
                                        .background(Color("LightColor"))
                                        .cornerRadius(5)
                                        .shadow(color: Color("DarkColor").opacity(0.1), radius: 5, x: 0, y: 5)
                                        .shadow(color: Color("DarkColor").opacity(0.08), radius: 5, x: 0, y: -5)
                                        .font(.system(size: 20))
                                        
                                        Text(Conifrm_Password)
                                            .font(.system(size: 18))
                                            .fontWeight(.bold)
                                            .foregroundColor(Color("GrayColor"))
                                            .padding(.top, 10)
                                        
                                        HStack(spacing: 15){
                                            
                                            VStack{
                                                
                                                if self.visible3{
                                                    
                                                    TextField(Repeat_New_Password, text: $confirmPassword)
                                                        .autocapitalization(.none)
                                                }
                                                else{
                                                    
                                                    SecureField(Repeat_New_Password, text: $confirmPassword)
                                                        .autocapitalization(.none)
                                                }
                                            }
                                            
                                            Button(action: {
                                                
                                                self.visible3.toggle()
                                                
                                            }) {
                                                
                                                Image(systemName: self.visible3 ? "eye.slash.fill" : "eye.fill")
                                                    .foregroundColor(self.color)
                                            }
                                            
                                        }
                                        .padding()
                                        .background(Color("LightColor"))
                                        .cornerRadius(5)
                                        .shadow(color: Color("DarkColor").opacity(0.1), radius: 5, x: 0, y: 5)
                                        .shadow(color: Color("DarkColor").opacity(0.08), radius: 5, x: 0, y: -5)
                                        .font(.system(size: 20))


                                    }
                                    .padding(.horizontal, 25)
                                    .padding(.top, 25)
                                    
                                        
                                    Button(action: {
                                        self.verify()
                                    })
                                    {
                                        
                                        Text(Change_Password)
                                            .font(.system(size: 20))
                                            .foregroundColor(.white)
                                            .fontWeight(.bold)
                                            .padding(.vertical)
                                            .frame(width: UIScreen.main.bounds.width - 50)
                                            .background(
                                                Color("PrimaryColor")
                                                //LinearGradient(gradient: .init(colors: [Color("PrimaryColor"), Color("LightColor")]), startPoint: .topLeading, endPoint: .bottomTrailing)
                                            )

                                    }
                                    .cornerRadius(8)
                                    .padding(.horizontal, 25)
                                    .padding(.top, 25)
                                        

                                    }
                                }
                            }

            }
            
            if self.alert
            {
                
                PopupView(alert: self.$alert, title: self.$title, message: self.$message)
            }

        }
        .navigationTitle(Change_Password)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear(perform: {
            translation.Translate()
            Old_Password = translation.Old_Password
            Enter_Old_Password = translation.Enter_Old_Password
            New_Password = translation.New_Password
            Enter_New_Password = translation.Enter_New_Password
            Conifrm_Password = translation.Conifrm_Password
            Repeat_New_Password = translation.Repeat_New_Password
            Wrong_password = translation.Wrong_password
            Password_changed_successfully = translation.Password_changed_successfully
            Error = translation.Error
            Message = translation.Message
            Change_Password = translation.Change_Password
            confirmPasswordVerification = translation.confirmPasswordVerification
            fieldsEmptyMessage = translation.fieldsEmptyMessage

        })

    }
    
    func verify(){
        
        if oldPassword != "" && newPassword != "" && confirmPassword != ""
        {
            if(newPassword == confirmPassword)
            {
                viewModel.changePassword(email:email, oldPassword:oldPassword, newPassword:newPassword,
                                         
                onSuccess: { (message) in
                    
                    if message == "Wrong password"
                    {
                        self.title = Error
                        self.message = message
                        self.alert.toggle()
                        return
                    }
                    else
                    {
                        self.title = Message
                        self.message = "Password changed successfully"
                        self.alert.toggle()
                        
                        oldPassword = ""
                        newPassword = ""
                        confirmPassword = ""
                        return
                    }
                },
                                        
                onError: {
                    self.title = Error
                    self.message = "Server error"
                    self.alert.toggle()
                    return
                })

            }
            else
            {
                self.title = Error
                self.message = confirmPasswordVerification
                self.alert.toggle()
                return
            }
        }
        else
        {
            self.title = Error
            self.message = fieldsEmptyMessage
            self.alert.toggle()
        }
            
    }

}
