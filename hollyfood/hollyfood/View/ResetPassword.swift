//
//  ResetPassword.swift
//  hollyfood
//
//  Created by Khairi on 22/11/2022.
//

import SwiftUI

struct ResetPassword: View {
    var body: some View {
        ResetPasswordHome()
    }
}

struct ResetPassword_Previews: PreviewProvider {
    static var previews: some View {
        ResetPassword()
    }
}


struct ResetPasswordHome: View {
    
    @ObservedObject var viewModel = UserViewModel()
    @State var reset = false

    var body: some View {
        
        NavigationView
        {
            VStack{
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 70, height: 70)
                    .padding(.top, 25)
                
                    ZStack{
                        
                        ZStack(alignment: .topTrailing) {
                            
                            GeometryReader{_ in
                                
                                VStack{
                                    
                                    VStack(alignment: .leading, spacing: 20){
                                        
                                        Text("Enter your email to reset your password")
                                            .font(.system(size: 20))
                                            .fontWeight(.bold)
                                            .foregroundColor(.gray)
                                            .padding(.top, 200)
                                        
                                        TextField("Email", text: $viewModel.email)
                                            .padding()
                                            .background(Color.white)
                                            .cornerRadius(5)
                                            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
                                            .shadow(color: Color.black.opacity(0.08), radius: 5, x: 0, y: -5)
                                            .font(.system(size: 20))
                                    }
                                    
                                    NavigationLink(destination: Tab().navigationBarBackButtonHidden(true), isActive: $reset){
                                        
                                        Button(action: {
                                            
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
                    }

            }
        }
    }
}
