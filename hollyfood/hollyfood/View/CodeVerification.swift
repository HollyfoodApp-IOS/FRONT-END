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
    
    @ObservedObject var translation = Translation()
    @State var Enter_your_password_reset_code_to_reset_your_password : String = ""
    @State var Enter_Code : String = ""
    @State var Reset_Password : String = ""
    @State var Code_Verification : String = ""
    @State var Error : String = ""
    @State var fieldsEmptyMessage : String = ""
    @State var Wrong_code : String = ""

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
                                        

                                        Text(Enter_your_password_reset_code_to_reset_your_password)
                                            .font(.system(size: 18))
                                            .fontWeight(.bold)
                                            .foregroundColor(Color("GrayColor"))
                                            .padding(.top, 120)
                                        
                                        TextField(Enter_Code, text: $viewModel.resetPasswordCode)
                                            .padding()
                                            .background(Color("LightColor"))
                                            .cornerRadius(5)
                                            .shadow(color: Color("DarkColor").opacity(0.1), radius: 5, x: 0, y: 5)
                                            .shadow(color: Color("DarkColor").opacity(0.08), radius: 5, x: 0, y: -5)
                                            .font(.system(size: 20))

                                        

                                    }
                                    .padding(.horizontal, 25)
                                    .padding(.top, 25)
                                    
                                    NavigationLink(destination: ResetPassword(codeP : $code).navigationBarBackButtonHidden(false), isActive: $resetPassword){
                                        
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
                                    .navigationTitle(Code_Verification)
                                    
                                    }
                                }
                            }
            }
            
            if self.alert
            {
                
                PopupView(alert: self.$alert, title: self.$title, message: self.$message)
            }
        }
        .navigationTitle(Code_Verification)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear(perform: {
            translation.Translate()
            Enter_your_password_reset_code_to_reset_your_password = translation.Enter_your_password_reset_code_to_reset_your_password
            Enter_Code = translation.Enter_Code
            Reset_Password = translation.Reset_Password
            Code_Verification = translation.Code_Verification
            Error = translation.Error
            fieldsEmptyMessage = translation.fieldsEmptyMessage
            Wrong_code = translation.Wrong_code

        })

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
                self.title = Error
                self.message = Wrong_code
                self.alert.toggle()
            })
        }
        else
        {
            self.title = Error
            self.message = fieldsEmptyMessage
            self.alert.toggle()
        }
            
    }
}
