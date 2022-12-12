//
//  ChangePassword.swift
//  hollyfood
//
//  Created by Khairi on 27/11/2022.
//

import SwiftUI

struct ChangePassword: View {
    
    
    var body: some View {
        ChangePassword_Code()
    }
}

struct ChangePassword_Previews: PreviewProvider {
    static var previews: some View {
        ChangePassword()
    }
}

struct ChangePassword_Code: View {
    
    @ObservedObject var viewModel = UserViewModel()
    @State var alert = false
    @State var title = ""
    @State var message = ""

    @State var email:String = UserViewModel.session?.email ?? ""
    @State var oldPassword:String = ""
    @State var newPassword:String = ""
    @State var confirmPassword:String = ""
    
    @State var visible = false
    @State var color = Color.black.opacity(0.7)

    var body: some View {
        ZStack{
            
            ZStack(alignment: .topTrailing) {
                
                VStack{
                    
                        GeometryReader{_ in
                                
                                VStack{
                                    
                                    VStack(alignment: .leading, spacing: 10){
                                        

                                        Text("Old Password")
                                            .font(.system(size: 18))
                                            .fontWeight(.bold)
                                            .foregroundColor(.gray)
                                            .padding(.top, 30)
                                        
                                        HStack(spacing: 15){
                                            
                                            VStack{
                                                
                                                if self.visible{
                                                    
                                                    TextField("Enter Old Password", text: $oldPassword)
                                                        .autocapitalization(.none)
                                                }
                                                else{
                                                    
                                                    SecureField("Enter Old Password", text: $oldPassword)
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
                                        
                                        
                                        Text("New Password")
                                            .font(.system(size: 18))
                                            .fontWeight(.bold)
                                            .foregroundColor(.gray)
                                            .padding(.top, 10)
                                        
                                        HStack(spacing: 15){
                                            
                                            VStack{
                                                
                                                if self.visible{
                                                    
                                                    TextField("Enter New Password", text: $newPassword)
                                                        .autocapitalization(.none)
                                                }
                                                else{
                                                    
                                                    SecureField("Enter New Password", text: $newPassword)
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
                                        
                                        Text("Conifrm Password")
                                            .font(.system(size: 18))
                                            .fontWeight(.bold)
                                            .foregroundColor(.gray)
                                            .padding(.top, 10)
                                        
                                        HStack(spacing: 15){
                                            
                                            VStack{
                                                
                                                if self.visible{
                                                    
                                                    TextField("Repeat New Password", text: $confirmPassword)
                                                        .autocapitalization(.none)
                                                }
                                                else{
                                                    
                                                    SecureField("Repeat New Password", text: $confirmPassword)
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


                                    }
                                    .padding(.horizontal, 25)
                                    .padding(.top, 25)
                                    
                                        
                                    Button(action: {
                                        self.verify()
                                    })
                                    {
                                        
                                        Text("Change Password")
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
            
            if self.alert
            {
                
                PopupView(alert: self.$alert, title: self.$title, message: self.$message)
            }

        }
        .navigationTitle("Change Password")
        .navigationBarTitleDisplayMode(.inline)

    }
    
    func verify(){
        
        if oldPassword != "" && newPassword != "" && confirmPassword != ""
        {
            if(newPassword == confirmPassword)
            {
                viewModel.changePassword(email:email, oldPassword:oldPassword, newPassword:newPassword,
                                         
                onSuccess: { (message) in
                    
                    if message == "Wrong Password"
                    {
                        self.title = "Error"
                        self.message = message
                        self.alert.toggle()
                        return
                    }
                    else
                    {
                        self.title = "Information"
                        self.message = "Password Changed Successfully"
                        self.alert.toggle()
                        
                        oldPassword = ""
                        newPassword = ""
                        confirmPassword = ""
                        return
                    }
                },
                                        
                onError: {
                    self.title = "Error"
                    self.message = "Server Error"
                    self.alert.toggle()
                    return
                })

            }
            else
            {
                self.title = "Error"
                self.message = "Password and Confirm Password fields must be exactly the same"
                self.alert.toggle()
                return
            }
        }
        else
        {
            self.title = "Error"
            self.message = "Please fill all the contents properly"
            self.alert.toggle()
            return
        }
            
    }

}
