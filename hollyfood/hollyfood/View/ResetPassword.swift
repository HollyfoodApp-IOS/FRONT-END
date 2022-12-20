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
    @State var color = Color.black.opacity(0.7)

    
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
                                        

                                        Text("Enter New Password")
                                            .font(.system(size: 18))
                                            .fontWeight(.bold)
                                            .foregroundColor(.gray)
                                            .padding(.top, 50)
                                        
                                        HStack(spacing: 15){
                                            
                                            VStack{
                                                
                                                if self.visible{
                                                    
                                                    TextField("Enter New Password", text: $viewModel.password)
                                                        .autocapitalization(.none)
                                                }
                                                else{
                                                    
                                                    SecureField("Enter New Password", text: $viewModel.password)
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
                                        .background(Color.white)
                                        .cornerRadius(5)
                                        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
                                        .shadow(color: Color.black.opacity(0.08), radius: 5, x: 0, y: -5)
                                        .font(.system(size: 20))
                                        
                                        Text("Confirm Password")
                                            .font(.system(size: 18))
                                            .fontWeight(.bold)
                                            .foregroundColor(.gray)
                                            .padding(.top, 10)
                                        
                                        HStack(spacing: 15){
                                            
                                            VStack{
                                                
                                                if self.visible2{
                                                    
                                                    TextField("Repeat New Password", text: $confirmPassword)
                                                        .autocapitalization(.none)
                                                }
                                                else{
                                                    
                                                    SecureField("Repeat New Password", text: $confirmPassword)
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
                                        .background(Color.white)
                                        .cornerRadius(5)
                                        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
                                        .shadow(color: Color.black.opacity(0.08), radius: 5, x: 0, y: -5)
                                        .font(.system(size: 20))

                                    }
                                    .padding(.horizontal, 25)
                                    .padding(.top, 25)
                                    
                                    NavigationLink(destination: Authentification().navigationBarBackButtonHidden(true), isActive: $login){
                                        
                                        Button(action: {
                                            self.verify()
                                        })
                                        {
                                            
                                            Text("Reset Password")
                                                .font(.system(size: 20))
                                                .foregroundColor(.white)
                                                .fontWeight(.bold)
                                                .padding(.vertical)
                                                .frame(width: UIScreen.main.bounds.width - 50)
                                                .background(
                                                    LinearGradient(gradient: .init(colors: [Color("PrimaryColor"), Color("PrimaryColor")]), startPoint: .topLeading, endPoint: .bottomTrailing)
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
        .navigationTitle("Reset Password")
        .navigationBarTitleDisplayMode(.inline)

    }
    
    func verify(){
        
        if viewModel.password != "" && confirmPassword != ""
        {
            if(viewModel.password == confirmPassword)
            {
                viewModel.resetPassword(code:codeP, password:viewModel.password,
                                                        
                onSuccess: {
                    login = true
                    self.title = "Information"
                    self.message = "Password Reset Successfully"
                    self.alert.toggle()                    
                },
                                        
                onError: {
                    self.message = "Error"
                    self.message = "Server Error"
                    self.alert.toggle()

                })

            }
            else
            {
                self.message = "Error"
                self.message = "Password Mismatch"
                self.alert.toggle()
            }
        }
        else
        {
            self.message = "Error"
            self.message = "Please fill all the contents properly"
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

