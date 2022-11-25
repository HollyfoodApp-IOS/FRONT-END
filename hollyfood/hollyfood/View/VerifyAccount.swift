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
    @State var error = ""
    
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
                                            

                                            Text("Enter Email")
                                                .font(.system(size: 18))
                                                .fontWeight(.bold)
                                                .foregroundColor(.gray)
                                                .padding(.top, 50)
                                            
                                            TextField("Email", text: $viewModel.email)
                                                .padding()
                                                .background(Color.white)
                                                .cornerRadius(5)
                                                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
                                                .shadow(color: Color.black.opacity(0.08), radius: 5, x: 0, y: -5)
                                                .font(.system(size: 20))
                                            
                                            Text("Enter Verification Code")
                                                .font(.system(size: 18))
                                                .fontWeight(.bold)
                                                .foregroundColor(.gray)
                                                .padding(.top, 10)
                                            
                                            TextField("Verification Code", text: $viewModel.verificationCode)
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
                                            
                                            Text("Verify Account")
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
        
        if viewModel.email != "" && viewModel.verificationCode != ""
        {
            viewModel.verifyAccount(email:viewModel.email, code:viewModel.verificationCode,
                                                    
            onSuccess: {
                self.error = "Account Verified Successfully"
                self.alert.toggle()
                viewModel.email = ""
                viewModel.verificationCode = ""
            },
                                    
            onError: {
                self.error = "Invalid Email or Code"
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

struct VerifyAccount_Previews: PreviewProvider {
    static var previews: some View {
        VerifyAccount()
    }
}
