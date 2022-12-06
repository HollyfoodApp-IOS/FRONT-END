//
//  ForgotPassword.swift
//  hollyfood
//
//  Created by Khairi on 24/11/2022.
//

import SwiftUI

struct ForgotPassword: View {
    var body: some View {
        ForgotPassword_Code()
    }
}

struct ForgotPassword_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPassword()
    }
}

struct ForgotPassword_Code: View {
    
    @ObservedObject var viewModel = UserViewModel()
    @State var codeVerification = false
    @State var alert = false
    @State var error = ""

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
                                        
                                        Text("Enter your email to recieve a password reset code")
                                            .font(.system(size: 18))
                                            .fontWeight(.bold)
                                            .foregroundColor(.gray)
                                            .padding(.top, 120)
                                        
                                        TextField("Email", text: $viewModel.email)
                                            .padding()
                                            .background(Color.white)
                                            .cornerRadius(5)
                                            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
                                            .shadow(color: Color.black.opacity(0.08), radius: 5, x: 0, y: -5)
                                            .font(.system(size: 20))
                                        

                                    }
                                    .padding(.horizontal, 25)
                                    .padding(.top, 25)

                                    
                                    NavigationLink(destination: CodeVerification().navigationBarBackButtonHidden(false), isActive: $codeVerification){
                                        
                                        Button(action: {
                                            self.verify()
                                        })
                                        {
                                            
                                            Text("Send")
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
                                    .navigationTitle("Forgot Password")
                                    
                                }
                            }
                }
            }
            
            if self.alert
            {
                
                ErrorView(alert: self.$alert, error: self.$error)
            }

        }
            .navigationTitle("Forgot Password")
            .navigationBarTitleDisplayMode(.inline)

        
    }
    
    func verify(){
        
        if viewModel.email != ""
        {
            viewModel.forgotPassword(email: viewModel.email,
                                    
            onSuccess: {
                codeVerification=true
                self.error = "RESET"
                self.alert.toggle()
            },
                                    
            onError: {
                self.error = "User Not Found"
                self.alert.toggle()
            })
        }
        else
        {
            self.error = "Please fill all the contents properly"
            self.alert.toggle()
        }
            
    }

    
}

