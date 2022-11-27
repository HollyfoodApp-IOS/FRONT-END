//
//  EditProfile.swift
//  hollyfood
//
//  Created by Khairi on 21/11/2022.
//

import SwiftUI

struct EditProfile: View {
    
    var body: some View {
        EditProfile_Code()
    }
    
}

struct EditProfile_Previews: PreviewProvider {
    static var previews: some View {
        EditProfile()
    }
}

struct EditProfile_Code:  View {
    
    @ObservedObject var viewModel = UserViewModel()
    @State var alert = false
    @State var error = ""
    
    @State var idUser:String = UserViewModel.idUder ?? ""
    @State var fullname:String = UserViewModel.session?.fullname ?? ""
    @State var email:String = UserViewModel.session?.email ?? ""
    @State var phone:String = UserViewModel.session?.phone ?? ""
    @State var role:String = UserViewModel.session?.role ?? ""
    
    var body: some View {
        
        ZStack{
            
            ZStack(alignment: .topTrailing) {
                
                VStack{
                    
                        GeometryReader{_ in
                                
                                VStack{
                                    
                                    VStack(alignment: .leading, spacing: 10){
                                        

                                        Text("Full Name")
                                            .font(.system(size: 18))
                                            .fontWeight(.bold)
                                            .foregroundColor(.gray)
                                            .padding(.top, 30)
                                        
                                        TextField("Full Name", text: $fullname)
                                            .padding()
                                            .background(Color.white)
                                            .cornerRadius(5)
                                            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
                                            .shadow(color: Color.black.opacity(0.08), radius: 5, x: 0, y: -5)
                                            .font(.system(size: 20))
                                        
                                        Text("Email")
                                            .font(.system(size: 18))
                                            .fontWeight(.bold)
                                            .foregroundColor(.gray)
                                            .padding(.top, 10)
                                        
                                        TextField("Email", text: $email)
                                            .padding()
                                            .background(Color.white)
                                            .cornerRadius(5)
                                            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
                                            .shadow(color: Color.black.opacity(0.08), radius: 5, x: 0, y: -5)
                                            .font(.system(size: 20))
                                        
                                        Text("Phone Number")
                                            .font(.system(size: 18))
                                            .fontWeight(.bold)
                                            .foregroundColor(.gray)
                                            .padding(.top, 10)
                                        
                                        TextField("Phone Number", text: $phone)
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
                                        
                                        Text("Edit Profile")
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
        .navigationTitle("Edit Profile")
        .navigationBarTitleDisplayMode(.inline)
        
    }
    
    func verify(){
        
        if fullname != "" && email != "" && phone != ""
        {
            
            viewModel.editProfile(id: idUser, fullname:fullname, email:email, phone:phone, onSuccess: {(message) in
                
                print("Message is: "+message)
                if(message == "Email Already Exist")
                {
                    self.error = "Email Already Exist"
                    self.alert.toggle()
                    return
                }
                else
                {
                    idUser = UserViewModel.idUder ?? ""
                    fullname = UserViewModel.session?.fullname ?? ""
                    email = UserViewModel.session?.email ?? ""
                    phone = UserViewModel.session?.phone ?? ""
                    role = UserViewModel.session?.role ?? ""
                    
                    print(" ")
                    print("full name is: "+fullname)

                    self.error = "Profile Updated Successfully"
    
                    self.alert.toggle()

                }
                
            })

                            
        }
        else{
            self.error = "Please fill all the contents properly"
            self.alert.toggle()

        }
    }
}


