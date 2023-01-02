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
    @State var title = ""
    @State var message = ""
    @State var id:String = UserViewModel.session?.id ?? ""
    @State var fullname:String = UserViewModel.session?.fullname ?? ""
    @State var email:String = UserViewModel.session?.email ?? ""
    @State var phone:String = UserViewModel.session?.phone ?? ""
    @State var role:String = UserViewModel.session?.role ?? ""
    @State var image:String = UserViewModel.session?.image ?? ""

    @ObservedObject var translation = Translation()
    @State var Full_Name : String = ""
    @State var Enter_Full_Name : String = ""
    @State var Email : String = ""
    @State var Enter_Email : String = ""
    @State var Phone_Number : String = ""
    @State var Enter_Phone_Number : String = ""
    @State var Edit_Profile : String = ""
    @State var Error : String = ""
    @State var Message : String = ""
    @State var Email_already_exist : String = ""
    @State var Profile_updated_successfully : String = ""
    @State var fieldsEmptyMessage : String = ""
    @State var selectedImage: UIImage?
    @State var showImagePicker : Bool = false


    var body: some View {
        
        ZStack{
            
            ZStack(alignment: .topTrailing) {
                
                VStack{
                    
                        if let selectedImage = selectedImage {
                        
                            Image(uiImage:selectedImage) .resizable()
                                .cornerRadius(7)
                                .padding(1) // Width of the border
                                .background(Color.gray.opacity(0.10))
                                .cornerRadius(10)
                                
                                .clipShape(Circle())
                                
                                .scaledToFit()
                               
                                .frame(width: 100, height: 100)
                                .offset(x:3,y:40)
                                .padding(.top,10)
                        
                        }
                        else
                        {
                            AsyncImage(url: URL(string: Statics.URL+"img/"+(UserViewModel.session?.image ??  "") ),
                                       content:{ image in
                                
                                        image
                                            .resizable()
                                            .aspectRatio( contentMode: .fill)
                                            .clipped()
                                            .clipShape(Rectangle())
                                            .frame( width:80, height: 80).cornerRadius(20.0)
                                
                            },placeholder: { })
                            
                        }
                    
                        GeometryReader{_ in
                                
                                VStack{
                                    
                                    VStack(alignment: .leading, spacing: 10){
                                        

                                        Text(Full_Name)
                                            .font(.system(size: 18))
                                            .fontWeight(.bold)
                                            .foregroundColor(Color("GrayColor"))
                                            .padding(.top, 30)
                                        
                                        TextField(Enter_Full_Name, text: $fullname)
                                            .padding()
                                            .background(Color("LightColor"))
                                            .cornerRadius(5)
                                            .shadow(color: Color("DarkColor").opacity(0.1), radius: 5, x: 0, y: 5)
                                            .shadow(color: Color("DarkColor").opacity(0.08), radius: 5, x: 0, y: -5)
                                            .font(.system(size: 20))
                                        
                                        Text(Email)
                                            .font(.system(size: 18))
                                            .fontWeight(.bold)
                                            .foregroundColor(Color("GrayColor"))
                                            .padding(.top, 10)
                                        
                                        TextField(Enter_Email, text: $email)
                                            .padding()
                                            .background(Color("LightColor"))
                                            .cornerRadius(5)
                                            .shadow(color: Color("DarkColor").opacity(0.1), radius: 5, x: 0, y: 5)
                                            .shadow(color: Color("DarkColor").opacity(0.08), radius: 5, x: 0, y: -5)
                                            .font(.system(size: 20))
                                        
                                        Text(Phone_Number)
                                            .font(.system(size: 18))
                                            .fontWeight(.bold)
                                            .foregroundColor(Color("GrayColor"))
                                            .padding(.top, 10)
                                        
                                        TextField(Enter_Phone_Number, text: $phone)
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
                                        
                                        Text(Edit_Profile)
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
                .sheet(isPresented: $showImagePicker)
                {
                    
                    ImagePicker(sourceType: .photoLibrary, selectedImage: $selectedImage)
                    
                }

            }
            
            if self.alert
            {
                
                PopupView(alert: self.$alert, title: self.$title, message: self.$message)
            }

        }
        .onAppear(perform: {
            translation.Translate()
            Full_Name = translation.Full_Name
            Enter_Full_Name = translation.Enter_Full_Name
            Email = translation.Email
            Enter_Email = translation.Enter_Email
            Phone_Number = translation.Phone_Number
            Enter_Phone_Number = translation.Enter_Phone_Number
            Edit_Profile = translation.Edit_Profile
            Error = translation.Error
            Message = translation.Message
            Email_already_exist = translation.Email_already_exist
            Profile_updated_successfully = translation.Profile_updated_successfully
            fieldsEmptyMessage = translation.fieldsEmptyMessage

        })
        .navigationTitle(Edit_Profile)
        .navigationBarTitleDisplayMode(.inline)
        
    }
    
    func verify(){
        
        if fullname != "" && email != "" && phone != ""
        {
            
            viewModel.editProfile(id: id, fullname:fullname, email:email, phone:phone, onSuccess: {(message) in
                
                if message == "Email already exist"
                {
                    self.title = Error
                    self.message = Email_already_exist
                    self.alert.toggle()
                    return

                }
                else
                {
                                        
                    id = UserViewModel.session?.id ?? ""
                    fullname = UserViewModel.session?.fullname ?? ""
                    email = UserViewModel.session?.email ?? ""
                    phone = UserViewModel.session?.phone ?? ""
                    role = UserViewModel.session?.role ?? ""
                    
                    self.title = Message
                    self.message = Profile_updated_successfully
    
                    self.alert.toggle()

                }
                
            })

        }
        else{
            
            self.title = Error
            self.message = fieldsEmptyMessage
            self.alert.toggle()

        }
    }
}


