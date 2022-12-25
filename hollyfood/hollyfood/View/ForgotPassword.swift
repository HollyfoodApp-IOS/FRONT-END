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
    @State var title = ""
    @State var message = ""
    
    @ObservedObject var translation = Translation()
    @State var Forgot_Password : String = ""
    @State var Enter_your_email_to_recieve_a_password_reset_code : String = ""
    @State var Enter_Email : String = ""
    @State var Send : String = ""
    @State var Error : String = ""
    @State var Message : String = ""
    @State var Password_reset_code_has_been_sent_successfully : String = ""
    @State var User_not_found : String = ""
    @State var fieldsEmptyMessage : String = ""

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
                                        
                                        Text(Enter_your_email_to_recieve_a_password_reset_code)
                                            .font(.system(size: 18))
                                            .fontWeight(.bold)
                                            .foregroundColor(Color("GrayColor"))
                                            .padding(.top, 120)
                                        
                                        TextField(Enter_Email, text: $viewModel.email)
                                            .padding()
                                            .background(Color("LightColor"))
                                            .cornerRadius(5)
                                            .shadow(color: Color("DarkColor").opacity(0.1), radius: 5, x: 0, y: 5)
                                            .shadow(color: Color("DarkColor").opacity(0.08), radius: 5, x: 0, y: -5)
                                            .font(.system(size: 20))
                                        

                                    }
                                    .padding(.horizontal, 25)
                                    .padding(.top, 25)

                                    
                                    NavigationLink(destination: CodeVerification().navigationBarBackButtonHidden(false), isActive: $codeVerification){
                                        
                                        Button(action: {
                                            self.verify()
                                        })
                                        {
                                            
                                            Text(Send)
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
                                    .navigationTitle(Forgot_Password)
                                    
                                }
                            }
                }
            }
            
            if self.alert
            {
                
                PopupView(alert: self.$alert, title: self.$title, message: self.$message)
            }

        }
        .navigationTitle(Forgot_Password)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear(perform: {
            translation.Translate()
            Forgot_Password = translation.Forgot_Password
            Enter_your_email_to_recieve_a_password_reset_code = translation.Enter_your_email_to_recieve_a_password_reset_code
            Enter_Email = translation.Enter_Email
            Send = translation.Send
            Error = translation.Error
            Message = translation.Message
            Password_reset_code_has_been_sent_successfully = translation.Password_reset_code_has_been_sent_successfully
            User_not_found = translation.User_not_found
            fieldsEmptyMessage = translation.fieldsEmptyMessage

        })

        
    }
    
    func verify(){
        
        if viewModel.email != ""
        {
            viewModel.forgotPassword(email: viewModel.email,
                                    
            onSuccess: {
                codeVerification=true
                
                self.title = Message
                self.message = Password_reset_code_has_been_sent_successfully
                self.alert.toggle()
            },
                                    
            onError: {
                
                self.title = Error
                self.message = User_not_found
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

