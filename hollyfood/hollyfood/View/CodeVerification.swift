//
//  CodeVerification.swift
//  hollyfood
//
//  Created by Khairi on 24/11/2022.
//

import SwiftUI

struct CodeVerification: View {
    var body: some View {
        CodeVerificationHome()
    }
}

struct CodeVerification_Previews: PreviewProvider {
    static var previews: some View {
        CodeVerification()
    }
}

struct CodeVerificationHome: View {
    
    @ObservedObject var viewModel = UserViewModel()
    @State var resetPassword = false
    @State var alert = false
    @State var title = ""
    @State var message = ""
    @State var code = ""
    
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
                                        

                                        Text("Enter your password reset code to reset your password")
                                            .font(.system(size: 18))
                                            .fontWeight(.bold)
                                            .foregroundColor(.gray)
                                            .padding(.top, 120)
                                        
                                        TextField("Code", text: $viewModel.resetPasswordCode)
                                            .padding()
                                            .background(Color.white)
                                            .cornerRadius(5)
                                            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
                                            .shadow(color: Color.black.opacity(0.08), radius: 5, x: 0, y: -5)
                                            .font(.system(size: 20))

                                        

                                    }
                                    .padding(.horizontal, 25)
                                    .padding(.top, 25)
                                    
                                    NavigationLink(destination: ResetPassword(codeP : $code).navigationBarBackButtonHidden(false), isActive: $resetPassword){
                                        
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
                                    .navigationTitle("Code Verification")
                                    
                                    }
                                }
                            }
            }
            
            if self.alert
            {
                
                PopupView(alert: self.$alert, title: self.$title, message: self.$message)
            }
        }
        .navigationTitle("Code Verification")
        .navigationBarTitleDisplayMode(.inline)

    }
    
    func verify(){
        
        if viewModel.resetPasswordCode != ""
        {
            viewModel.resetPasswordCodeVerification(code: viewModel.resetPasswordCode,
                                                    
            onSuccess: {
                code = viewModel.resetPasswordCode
                resetPassword=true
            },
                                    
            onError: {
                self.title = "Error"
                self.message = "Wrong Code"
                self.alert.toggle()
            })
        }
        else
        {
            self.title = "Error"
            self.message = "Please fill all the contents properly"
            self.alert.toggle()
        }
            
    }
}
