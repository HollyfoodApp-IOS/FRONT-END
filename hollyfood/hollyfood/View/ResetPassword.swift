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
    @State var error = ""
    @State var confirmPassword = ""
    @Binding var codeP : String
    
    var body: some View {
        
        NavigationView
        {
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
                                            
                                            TextField("New Password", text: $viewModel.password)
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
                                            
                                            TextField("Confirm Password", text: $confirmPassword)
                                                .padding()
                                                .background(Color.white)
                                                .cornerRadius(5)
                                                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
                                                .shadow(color: Color.black.opacity(0.08), radius: 5, x: 0, y: -5)
                                                .font(.system(size: 20))


                                            

                                        }
                                        .padding(.horizontal, 25)
                                        .padding(.top, 25)
                                        
                                            
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
                                                    LinearGradient(gradient: .init(colors: [Color("Color"), Color("Color 1")]), startPoint: .topLeading, endPoint: .bottomTrailing)
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
                    
                    ErrorView(alert: self.$alert, error: self.$error)
                }

            }
        }
    }
    
    func verify(){
        
        if viewModel.password != "" && confirmPassword != ""
        {
            if(viewModel.password == confirmPassword)
            {
                viewModel.resetPassword(code:codeP, password:viewModel.password,
                                                        
                onSuccess: {
                    login = true
                    self.error = "Password Reset Successfully"
                    self.alert.toggle()
                    Authentification()
                    
                },
                                        
                onError: {
                    self.error = "Error"
                    self.alert.toggle()

                })

            }
            else
            {
                self.error = "Password Mismatch"
                self.alert.toggle()
            }
        }
        else
        {
            self.error = "Please fill all the contents properly"
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

