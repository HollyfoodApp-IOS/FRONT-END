//
//  ResetPassword.swift
//  hollyfood
//
//  Created by Khairi on 24/11/2022.
//

import SwiftUI

struct ResetPassword: View {
    
    @ObservedObject var viewModel = UserViewModel()
    @State var login = false
    @State var alert = false
    @State var title = ""
    @State var message = ""
    @State var confirmPassword = ""
    @Binding var codeP : String
    @State var visible = false
    @State var visible2 = false
    @State var color = Color("DarkColor").opacity(0.7)

    @ObservedObject var translation = Translation()
    @State var Reset_Password : String = ""
    @State var New_Password : String = ""
    @State var Enter_New_Password : String = ""
    @State var Conifrm_Password : String = ""
    @State var Repeat_New_Password : String = ""
    @State var Error : String = ""
    @State var Message : String = ""
    @State var fieldsEmptyMessage : String = ""
    @State var Password_reset_successfully : String = ""
    @State var confirmPasswordVerification : String = ""

    var body: some View {
        
        ZStack{
            
            ZStack(alignment: .topTrailing) {
                
                VStack{
                    
                    Image("logo")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 70, height: 70)
                        .padding(.top, 25)
                                            
                        GeometryReader{_ in
                                
                                VStack{
                                    
                                    VStack(alignment: .leading, spacing: 15){
                                        

                                        Text(New_Password)
                                            .font(.system(size: 18))
                                            .fontWeight(.bold)
                                            .foregroundColor(Color("GrayColor"))
                                            .padding(.top, 50)
                                        
                                        HStack(spacing: 15){
                                            
                                            VStack{
                                                
                                                if self.visible{
                                                    
                                                    TextField(Enter_New_Password, text: $viewModel.password)
                                                        .autocapitalization(.none)
                                                }
                                                else{
                                                    
                                                    SecureField(Enter_New_Password, text: $viewModel.password)
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
                                        
                                        Text(Conifrm_Password)
                                            .font(.system(size: 18))
                                            .fontWeight(.bold)
                                            .foregroundColor(Color("GrayColor"))
                                            .padding(.top, 10)
                                        
                                        HStack(spacing: 15){
                                            
                                            VStack{
                                                
                                                if self.visible2{
                                                    
                                                    TextField(Repeat_New_Password, text: $confirmPassword)
                                                        .autocapitalization(.none)
                                                }
                                                else{
                                                    
                                                    SecureField(Repeat_New_Password, text: $confirmPassword)
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

                                    }
                                    .padding(.horizontal, 25)
                                    .padding(.top, 25)
                                    
                                    NavigationLink(destination: Authentification().navigationBarBackButtonHidden(true), isActive: $login){
                                        
                                        Button(action: {
                                            self.verify()
                                        })
                                        {
                                            
                                            Text(Reset_Password)
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
                
            }
            
            if self.alert
            {
                PopupView(alert: self.$alert, title: self.$title, message: self.$message)
            }

        }
        .navigationTitle(Reset_Password)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear(perform: {
            translation.Translate()
            Reset_Password = translation.Reset_Password
            New_Password = translation.New_Password
            Enter_New_Password = translation.Enter_New_Password
            Conifrm_Password = translation.Conifrm_Password
            Repeat_New_Password = translation.Repeat_New_Password
            Error = translation.Error
            Message = translation.Message
            fieldsEmptyMessage = translation.fieldsEmptyMessage
            Password_reset_successfully = translation.Password_reset_successfully
            confirmPasswordVerification = translation.confirmPasswordVerification

        })

    }
    
    func verify(){
        
        if viewModel.password != "" && confirmPassword != ""
        {
            if(viewModel.password == confirmPassword)
            {
                viewModel.resetPassword(code:codeP, password:viewModel.password,
                                                        
                onSuccess: {
                    login = true
                    self.title = Message
                    self.message = Password_reset_successfully
                    self.alert.toggle()                    
                },
                                        
                onError: {
                    self.message = Error
                    self.message = "Server error"
                    self.alert.toggle()

                })

            }
            else
            {
                self.message = Error
                self.message = confirmPasswordVerification
                self.alert.toggle()
            }
        }
        else
        {
            self.message = Error
            self.message = fieldsEmptyMessage
            self.alert.toggle()
        }
            
    }

}

struct ResetPassword_Previews: PreviewProvider {
    
    @State static var code : String = ""
    
    static var previews: some View {
        ResetPassword(codeP : $code)
    }
}

