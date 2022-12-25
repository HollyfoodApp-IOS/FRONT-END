//
//  VerifyAccount.swift
//  hollyfood
//
//  Created by Khairi on 25/11/2022.
//

import SwiftUI

struct VerifyAccount: View {
    
    @ObservedObject var viewModel = UserViewModel()
    @State var alert = false
    @State var title = ""
    @State var message = ""

    @ObservedObject var translation = Translation()
    @State var Verify_Account : String = ""
    @State var Email : String = ""
    @State var Enter_Email : String = ""
    @State var Verification_Code : String = ""
    @State var Enter_Verification_Code : String = ""
    @State var Message : String = ""
    @State var Error : String = ""
    @State var Account_verified_successfully : String = ""
    @State var Invalid_email_or_verification_code : String = ""
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
                                        

                                        Text(Email)
                                            .font(.system(size: 18))
                                            .fontWeight(.bold)
                                            .foregroundColor(Color("GrayColor"))
                                            .padding(.top, 50)
                                        
                                        TextField(Enter_Email, text: $viewModel.email)
                                            .padding()
                                            .background(Color("LightColor"))
                                            .cornerRadius(5)
                                            .shadow(color: Color("DarkColor").opacity(0.1), radius: 5, x: 0, y: 5)
                                            .shadow(color: Color("DarkColor").opacity(0.08), radius: 5, x: 0, y: -5)
                                            .font(.system(size: 20))
                                        
                                        Text(Verification_Code)
                                            .font(.system(size: 18))
                                            .fontWeight(.bold)
                                            .foregroundColor(Color("GrayColor"))
                                            .padding(.top, 10)
                                        
                                        TextField(Enter_Verification_Code, text: $viewModel.verificationCode)
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
                                        
                                        Text(Verify_Account)
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
        .navigationTitle(Verify_Account)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear(perform: {
            translation.Translate()
            Verify_Account = translation.Verify_Account
            Email = translation.Email
            Enter_Email = translation.Enter_Email
            Verification_Code = translation.Verification_Code
            Enter_Verification_Code = translation.Enter_Verification_Code
            Message = translation.Message
            Error = translation.Error
            Account_verified_successfully = translation.Account_verified_successfully
            Invalid_email_or_verification_code = translation.Invalid_email_or_verification_code
            fieldsEmptyMessage = translation.fieldsEmptyMessage

        })

    }
    
    func verify(){
        
        if viewModel.email != "" && viewModel.verificationCode != ""
        {
            viewModel.verifyAccount(email:viewModel.email, code:viewModel.verificationCode,
                                                    
            onSuccess: {
                self.title = Message
                self.message = Account_verified_successfully
                self.alert.toggle()
                viewModel.email = ""
                viewModel.verificationCode = ""
            },
                                    
            onError: {
                
                self.title = Error
                self.message = Invalid_email_or_verification_code
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

struct VerifyAccount_Previews: PreviewProvider {
    static var previews: some View {
        VerifyAccount()
    }
}
