//
//  Authentification.swift
//  hollyfood
//
//  Created by Khairi on 16/11/2022.
//

import SwiftUI
import GoogleSignIn

struct Authentification: View {
    
    @State private var unlocked = false
    
    var body: some View {
                
        NavigationView()
        {
            Home()
                .navigationTitle("Back")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarHidden(true)
        }

    }
}

struct Authentification_Previews: PreviewProvider {
    static var previews: some View {
        Authentification()
    }
}
struct Home: View {
    
    @State var index = 0
    @Namespace var name
    
    var body: some View {
        
        VStack{
            
            HStack{
                
                Spacer()
                
                Image("shape")
                    .frame(height:30)

            }

            Image("logo")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 70, height: 70)
            
            HStack(spacing: 0 ){
                Button(action: {
                    withAnimation(.spring()){
                        index = 0
                    }
                }){
                    VStack{
                        Text("Login")
                            .font(.system(size: 20))
                            .fontWeight(.bold)
                            .foregroundColor(index == 0 ? Color("DarkColor") : Color("GrayColor"))

                        ZStack{
                            Capsule()
                                .fill(Color.black.opacity(0.04))
                                .frame(height: 4)
                            
                            if index == 0{
                                Capsule()
                                    .fill(Color("PrimaryColor"))
                                    .frame(height: 4)
                                    .matchedGeometryEffect(id: "Tab", in: name)
                            }
                        }
                            
                    }
                }
                
                Button(action: {
                    withAnimation(.spring()){
                        index = 1
                    }
                }){
                    VStack{
                        Text("Sign Up")
                            .font(.system(size: 20))
                            .fontWeight(.bold)
                            .foregroundColor(index == 1 ? Color("DarkColor") : Color("GrayColor"))
                        
                        ZStack{
                            Capsule()
                                .fill(Color.black.opacity(0.04))
                                .frame(height: 4)
                            
                            if index == 1{
                                Capsule()
                                    .fill(Color("PrimaryColor"))
                                    .frame(height: 4)
                                    .matchedGeometryEffect(id: "Tab", in: name)
                            }
                        }
                            
                    }
                }
            }
            .padding(.top, 30)
            
            if(index == 0){
                Login()
            }
            else
            {
                SignUp()
            }
            
            Spacer()
        }
        
    }
}

struct Login: View{
    
    @ObservedObject var userViewModel = UserViewModel()
    @State private var isLogin = false
    @State var visible = false
    @State var color = Color("DarkColor").opacity(0.7)
    @State var alert = false
    @State var title = ""
    @State var message = ""
    @State var forgotPassword = false
    @State var verifyAccount = false

    var body : some View{
        
        ZStack{
            
            ZStack(alignment: .topTrailing) {
                
                GeometryReader{_ in
                    
                    VStack{
                        
                        VStack(alignment: .leading, spacing: 15){
                            
                            Text("Email")
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundColor(Color("GrayColor"))
                            
                            TextField("Email", text: $userViewModel.email)
                                .padding()
                                .background(Color("LightColor"))
                                .cornerRadius(5)
                                .shadow(color: Color("DarkColor").opacity(0.1), radius: 5, x: 0, y: 5)
                                .shadow(color: Color("DarkColor").opacity(0.08), radius: 5, x: 0, y: -5)
                            
                            Text("Password")
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundColor(Color("GrayColor"))
                            
                            HStack(spacing: 15){
                                
                                VStack{
                                    
                                    if self.visible{
                                        
                                        TextField("Password", text: $userViewModel.password)
                                            .autocapitalization(.none)
                                    }
                                    else{
                                        
                                        SecureField("Password", text: $userViewModel.password)
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
                            .background(Color("LightColor"))
                            .cornerRadius(5)
                            .shadow(color: Color("DarkColor").opacity(0.1), radius: 5, x: 0, y: 5)
                            .shadow(color: Color("DarkColor").opacity(0.08), radius: 5, x: 0, y: -5)

                            HStack(spacing:125)
                            {
                                NavigationLink(destination: ForgotPassword(), isActive: $forgotPassword){
                                  
                                    Button(action: { forgotPassword=true }) {
                                        Text("Forgot Password")
                                            .font(.system(size: 14))
                                            .fontWeight(.bold)
                                            .foregroundColor(Color("PrimaryColor"))
                                    }
                                    .padding(.top, 10)

                                }
                                
                                NavigationLink(destination: VerifyAccount(), isActive: $verifyAccount){
                                    
                                    Button(action: {verifyAccount=true }) {
                                        Text("Verify Account")
                                            .font(.system(size: 14))
                                            .fontWeight(.bold)
                                            .foregroundColor(Color("PrimaryColor"))
                                    }
                                    .padding(.top, 10)
                                    
                                }
                            }
                            
                        }
                        .padding(.horizontal, 25)
                        .padding(.top, 25)
                        
                        NavigationLink(destination: Tab().navigationBarBackButtonHidden(true), isActive: $isLogin){
                            
                            Button(action: {
                                
                                self.verify()
                            })
                            {
                                Text("Login")
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
                        
                        Button(action: {
                            
                        }) {
                            HStack(spacing: 35){
                                Image(systemName: "faceid")
                                    .font(.system(size: 26))
                                    .foregroundColor(Color("PrimaryColor"))
                                
                                Text("Login With Faceid")
                                    .font(.system(size: 20))
                                    .foregroundColor(Color("PrimaryColor"))
                                
                                Spacer(minLength: 0)
                            }
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 8).stroke(Color("PrimaryColor"), lineWidth: 1))
                        }
                        .padding(.horizontal, 25)
                        .padding(.top, 30)
                                                
                    }
                }
            }
            
            
            if self.alert{
                
                PopupView(alert: self.$alert, title: self.$title, message: self.$message)
            }

        }
        
    }
    
    func verify(){
        
        if userViewModel.email != "" && userViewModel.password != ""
        {
            
            userViewModel.LogIn(email: userViewModel.email , password: userViewModel.password, onSuccess: {(message) in
                
                print("Message is "+message)
                if(message == "Invalid Email Or Password")
                {
                    self.title = "Error"
                    self.message = "Invalid email or password"
                    self.alert.toggle()
                    print(isLogin)
                    return
                }
                else if(message == "Account Not Verified Yet")
                {
                    self.title = "Information"
                    self.message = "Account Not Verified Yet"
                    self.alert.toggle()
                    print(isLogin)
                    return
                }
                else
                {
                    isLogin = true
                }
                
            })

        }
        else{
            self.title = "Error"
            self.message = "Please fill all the contents properly"
            self.alert.toggle()
        }
    }
    
    
}

struct SignUp: View{
    
    @ObservedObject var userViewModel = UserViewModel()
    @State var confirmPassword = ""
    @State var alert = false
    @State var title = ""
    @State var message = ""
    @State var visible = false
    @State var visible2 = false
    @State var color = Color.black.opacity(0.7)
    @State var selectedRole = ""

    var body : some View{
        
        ZStack{
            ZStack(alignment: .topTrailing) {
                
                GeometryReader{_ in
                    
                    VStack{
    
                        VStack(alignment: .leading, spacing: 8){
                            
                            Text("Full Name")
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundColor(Color("GrayColor"))

                            TextField("Full Name", text: $userViewModel.fullname)
                                .padding()
                                .background(Color("LightColor"))
                                .cornerRadius(5)
                                .shadow(color: Color("DarkColor").opacity(0.1), radius: 5, x: 0, y: 5)
                                .shadow(color: Color("DarkColor").opacity(0.08), radius: 5, x: 0, y: -5)
                                .font(.system(size: 12))
                            
                            Text("Email")
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundColor(Color("GrayColor"))

                            TextField("Email", text: $userViewModel.email)
                                .padding()
                                .background(Color("LightColor"))
                                .cornerRadius(5)
                                .shadow(color: Color("DarkColor").opacity(0.1), radius: 5, x: 0, y: 5)
                                .shadow(color: Color("DarkColor").opacity(0.08), radius: 5, x: 0, y: -5)
                                .font(.system(size: 12))
                            
                            Text("Password")
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundColor(Color("GrayColor"))

                            HStack(spacing: 15){
                                
                                VStack{
                                    
                                    if self.visible{
                                        
                                        TextField("Password", text: $userViewModel.password)
                                            .autocapitalization(.none)
                                    }
                                    else{
                                        
                                        SecureField("Password", text: $userViewModel.password)
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
                            .background(Color("LightColor"))
                            .cornerRadius(5)
                            .shadow(color: Color("DarkColor").opacity(0.1), radius: 5, x: 0, y: 5)
                            .shadow(color: Color("DarkColor").opacity(0.08), radius: 5, x: 0, y: -5)
                            .font(.system(size: 12))
                            
                            Text("Confirm Password")
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundColor(Color("GrayColor"))

                            HStack(spacing: 15){
                                
                                VStack{
                                    
                                    if self.visible2{
                                        
                                        TextField("Confirm Password", text: $confirmPassword)
                                            .autocapitalization(.none)
                                    }
                                    else{
                                        
                                        SecureField("Confirm Password", text: $confirmPassword)
                                            .autocapitalization(.none)
                                    }
                                }
                                
                                Button(action: {
                                    
                                    self.visible2.toggle()
                                    
                                }) {
                                    
                                    Image(systemName: self.visible2 ? "eye.slash.fill" : "eye.fill")
                                        .foregroundColor(self.color)
                                }
                                
                            }
                            .padding()
                            .background(Color("LightColor"))
                            .cornerRadius(5)
                            .shadow(color: Color("DarkColor").opacity(0.1), radius: 5, x: 0, y: 5)
                            .shadow(color: Color("DarkColor").opacity(0.08), radius: 5, x: 0, y: -5)
                            .font(.system(size: 12))

                            
                            Text("Phone Number")
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundColor(Color("GrayColor"))

                            TextField("Phone Number", text: $userViewModel.phone)
                                .padding()
                                .background(Color("LightColor"))
                                .cornerRadius(5)
                                .shadow(color: Color("DarkColor").opacity(0.1), radius: 5, x: 0, y: 5)
                                .shadow(color: Color("DarkColor").opacity(0.08), radius: 5, x: 0, y: -5)
                                .font(.system(size: 12))
                            
                        }
                        .padding(.horizontal, 25)
                        .padding(.top, 10)
                        
                        VStack(alignment: .leading)
                        {
                            Text("Role")
                                 .font(.caption)
                                 .fontWeight(.bold)
                                 .foregroundColor(Color("GrayColor"))

                            Picker("Role: ", selection: $selectedRole){
                                ForEach(roles, id: \.self)
                                { role in
                                    Text(role)
                                }
                            }
                        }
                        .pickerStyle(.segmented)
                        .padding(.horizontal, 25)
                        .padding(.top, 5)

                        Button(action: {
                                
                                self.verify()
                            })
                            {
                                
                                Text("Sign Up")
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
            
            if self.alert{
                
                PopupView(alert: self.$alert, title: self.$title, message: self.$message)
            }

        }
        
    }
    
    func verify(){
        
        if userViewModel.fullname != "" && userViewModel.email != "" && userViewModel.password != "" && confirmPassword != "" && userViewModel.phone != "" {
            
            if userViewModel.fullname.count < 3 {
                
                self.title = "Error"
                self.message = "The full name must be at least 4 letters"
                self.alert.toggle()
                return
            }
            
            if userViewModel.password.count < 3 {
                
                self.title = "Error"
                self.message = "The password name must be at least 4 letters"
                self.alert.toggle()
                return
            }
            
            if userViewModel.phone.count != 8 {
                
                self.title = "Error"
                self.message = "The phone number is invalid"
                self.alert.toggle()
                return
            }
                        
            if userViewModel.password != confirmPassword {
                
                self.title = "Error"
                self.message = "Password and Confirm Password fields must be exactly the same"
                self.alert.toggle()
                return
            }
                
            if selectedRole == "" {
                
                self.title = "Error"
                self.message = "Role Is Required"
                self.alert.toggle()
                return
            }

            userViewModel.SignUp(user: User(id: "", fullname: userViewModel.fullname, email:userViewModel.email, password: userViewModel.password, phone: userViewModel.phone, address: "", role: selectedRole), onSuccess: {
                
                self.title = "Information"
                self.message = "Your account has been created successfully!"
                self.alert.toggle()
                userViewModel.fullname = ""
                userViewModel.email = ""
                userViewModel.password = ""
                userViewModel.phone = ""
                confirmPassword = ""
                return

            })

        }
        else{
            
            self.title = "Error"
            self.message = "Please fill all the contents properly"
            self.alert.toggle()
        }
    }

    
}

struct PopupView : View {
    
    @State var color = Color("DarkColor").opacity(0.7)
    @Binding var alert : Bool
    @Binding var title : String
    @Binding var message : String

    var body: some View{
        
        GeometryReader{_ in
            
            VStack{
                
                HStack{
                    
                    Text(self.title)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(self.color)
                    
                    Spacer()
                }
                .padding(.horizontal, 25)
                
                Text(self.message)
                .foregroundColor(self.color)
                .padding(.top)
                .padding(.horizontal, 25)
                
                Button(action: {
                    
                    self.alert.toggle()
                    
                }) {
                    
                    Text("Cancel")
                        .foregroundColor(.white)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 120)
                }
                .background(Color("PrimaryColor"))
                .cornerRadius(10)
                .padding(.top, 25)
                
            }
            .padding(.vertical, 25)
            .frame(width: UIScreen.main.bounds.width - 70)
            .background(Color("LightColor"))
            .cornerRadius(15)
        }
        .padding(.horizontal, 35)
        .padding(.top, 140)
        .background(Color("DarkColor").opacity(0.35).edgesIgnoringSafeArea(.all))
    }
}

var roles = ["Restaurant Manager", "Client"]
