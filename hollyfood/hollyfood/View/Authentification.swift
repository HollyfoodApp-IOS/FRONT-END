//
//  Authentification.swift
//  hollyfood
//
//  Created by Khairi on 16/11/2022.
//

import SwiftUI

struct Authentification: View {
    var body: some View {
        
        NavigationView()
        {
            Home()
                .navigationTitle("")
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
                    .frame(height:40)

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
                            .foregroundColor(index == 0 ? .black : .gray)
                        
                        //slide animation
                        ZStack{
                            Capsule()
                                .fill(Color.black.opacity(0.04))
                                .frame(height: 4)
                            
                            if index == 0{
                                Capsule()
                                    .fill(Color("Color"))
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
                            .foregroundColor(index == 1 ? .black : .gray)
                        
                        ZStack{
                            Capsule()
                                .fill(Color.black.opacity(0.04))
                                .frame(height: 4)
                            
                            if index == 1{
                                Capsule()
                                    .fill(Color("Color"))
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
    
    @ObservedObject var viewModel = UserViewModel()
    @State private var isLogin = false
    @State var visible = false
    @State var color = Color.black.opacity(0.7)
    @State var alert = false
    @State var error = ""
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
                                .foregroundColor(.gray)
                            
                            TextField("Email", text: $viewModel.email)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(5)
                                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
                                .shadow(color: Color.black.opacity(0.08), radius: 5, x: 0, y: -5)
                            
                            Text("Password")
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundColor(.gray)
                            
                            HStack(spacing: 15){
                                
                                VStack{
                                    
                                    if self.visible{
                                        
                                        TextField("Password", text: $viewModel.password)
                                            .autocapitalization(.none)
                                    }
                                    else{
                                        
                                        SecureField("Password", text: $viewModel.password)
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
                            
                            HStack(spacing:125)
                            {
                                NavigationLink(destination: ForgotPassword(), isActive: $forgotPassword){
                                  
                                    Button(action: { forgotPassword=true }) {
                                        Text("Forgot Password")
                                            .font(.system(size: 14))
                                            .fontWeight(.bold)
                                            .foregroundColor(Color("Color"))
                                    }
                                    .padding(.top, 10)

                                }
                                
                                NavigationLink(destination: VerifyAccount(), isActive: $verifyAccount){
                                    
                                    Button(action: {verifyAccount=true }) {
                                        Text("Verify Account")
                                            .font(.system(size: 14))
                                            .fontWeight(.bold)
                                            .foregroundColor(Color("Color"))
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
                                        LinearGradient(gradient: .init(colors: [Color("Color"), Color("Color 1")]), startPoint: .topLeading, endPoint: .bottomTrailing)
                                    )
                                
                            }
                            .cornerRadius(8)
                            .padding(.horizontal, 25)
                            .padding(.top, 25)
                            
                            
                        }
                        
                        Button(action: {}) {
                            HStack(spacing: 35){
                                Image(systemName: "faceid")
                                    .font(.system(size: 26))
                                    .foregroundColor(Color("Color"))
                                
                                Text("Login With Face ID")
                                    .font(.system(size: 20))
                                    .foregroundColor(Color("Color"))
                                
                                Spacer(minLength: 0)
                            }
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 8).stroke(Color("Color"), lineWidth: 1))
                        }
                        .padding(.horizontal, 25)
                        .padding(.top, 30)
                        
                        /*
                         HStack(spacing: 30){
                         ForEach(social, id: \.self){name in
                         
                         Button(action:{}){
                         
                         Image(name)
                         .renderingMode(.template)
                         .resizable()
                         .frame(width: 24, height: 24)
                         .foregroundColor(Color(name == "google" ? "Color" : "Color"))
                         
                         }
                         
                         }
                         }
                         .padding(.top, 25)
                         */
                        
                        
                    }
                }
            }
            
            
            if self.alert{
                
                ErrorView(alert: self.$alert, error: self.$error)
            }

        }
        
    }
    
    func verify(){
        
        if viewModel.email != "" && viewModel.password != ""
        {
            
            viewModel.LogIn(email: viewModel.email , password:viewModel.password, onSuccess: {(message) in
                
                print("Message is "+message)
                if(message == "Invalid Email Or Password")
                {
                    self.error = "Invalid email or password"
                    self.alert.toggle()
                    print(isLogin)
                    return
                }
                else if(message == "Account Not Verified Yet")
                {
                    self.error = "Account Not Verified Yet"
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
            self.error = "Please fill all the contents properly"
            self.alert.toggle()
        }
    }

    
}

struct SignUp: View{
    
    @ObservedObject var viewModel = UserViewModel()
    @State var confirmPassword = ""
    @State var alert = false
    @State var error = ""
    @State var visible = false
    @State var color = Color.black.opacity(0.7)


    var body : some View{
        
        ZStack{
            ZStack(alignment: .topTrailing) {
                GeometryReader{_ in
                    VStack{
    
                        VStack(alignment: .leading, spacing: 10){
                            
                            Text("Full Name")
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundColor(.gray)

                            TextField("Full Name", text: $viewModel.fullname)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(5)
                                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
                                .shadow(color: Color.black.opacity(0.08), radius: 5, x: 0, y: -5)
                                .font(.system(size: 12))
                            
                            Text("Email")
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundColor(.gray)

                            TextField("Email", text: $viewModel.email)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(5)
                                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
                                .shadow(color: Color.black.opacity(0.08), radius: 5, x: 0, y: -5)
                                .font(.system(size: 12))
                            
                            Text("Password")
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundColor(.gray)
                            
                            HStack(spacing: 15){
                                
                                VStack{
                                    
                                    if self.visible{
                                        
                                        TextField("Password", text: $viewModel.password)
                                            .autocapitalization(.none)
                                    }
                                    else{
                                        
                                        SecureField("Password", text: $viewModel.password)
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
                            .font(.system(size: 12))
                            
                            Text("Confirm Password")
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundColor(.gray)

                            HStack(spacing: 15){
                                
                                VStack{
                                    
                                    if self.visible{
                                        
                                        TextField("Confirm Password", text: $confirmPassword)
                                            .autocapitalization(.none)
                                    }
                                    else{
                                        
                                        SecureField("Confirm Password", text: $confirmPassword)
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
                            .font(.system(size: 12))

                            
                            Text("Phone Number")
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundColor(.gray)

                            TextField("Phone Number", text: $viewModel.phone)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(5)
                                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
                                .shadow(color: Color.black.opacity(0.08), radius: 5, x: 0, y: -5)
                                .font(.system(size: 12))
                            
                        }
                        .padding(.horizontal, 25)
                        .padding(.top, 25)
                        
                            
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
                                        LinearGradient(gradient: .init(colors: [Color("Color"), Color("Color 1")]), startPoint: .topLeading, endPoint: .bottomTrailing)
                                    )
                                
                            }
                            .cornerRadius(8)
                            .padding(.horizontal, 25)
                            .padding(.top, 25)

                        
                        /*Button(action: {
                            
                        }) {
                            HStack(spacing: 35){
                                Image(systemName: "faceid")
                                    .font(.system(size: 26))
                                    .foregroundColor(Color("Color"))
                                
                                Text("Sign Up With Face ID")
                                    .font(.system(size: 20))
                                    .foregroundColor(Color("Color"))
                                
                                Spacer(minLength: 0)
                            }
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 8).stroke(Color("Color"), lineWidth: 1))
                        }
                        .padding(.horizontal, 25)
                        .padding(.top, 10)*/
                        
                        /*
                         HStack(spacing: 30){
                            ForEach(social, id: \.self){name in
                                
                                Button(action:{}){
                                    
                                    Image(name)
                                        .renderingMode(.template)
                                        .resizable()
                                        .frame(width: 24, height: 24)
                                        .foregroundColor(Color(name == "google" ? "Color" : "Color"))

                                }
                                
                            }
                        }
                        .padding(.top, 25)
                         */
                        
                        
                    }

                }

            }
            
            if self.alert{
                
                ErrorView(alert: self.$alert, error: self.$error)
            }


        }
        
    }
    
    func verify(){
        
        if viewModel.fullname != "" && viewModel.email != "" && viewModel.password != "" && confirmPassword != "" && viewModel.phone != "" {
            
            if viewModel.fullname.count < 3 {
                self.error = "The full name must be at least 4 letters"
                self.alert.toggle()
                return
            }
            
            if viewModel.password.count < 3 {
                self.error = "The password name must be at least 4 letters"
                self.alert.toggle()
                return
            }
            
            if viewModel.phone.count != 8 {
                
                self.error = "The phone number is invalid"
                self.alert.toggle()
                return
            }
                        
            if viewModel.password != confirmPassword {
                
                self.error = "Password and Confirm Password fields must be exactly the same"
                self.alert.toggle()
                return
            }
                
            
            viewModel.SignUp(user: User(fullname: viewModel.fullname, email:viewModel.email, password: viewModel.password, phone: viewModel.phone, address: "", role: "Admin"), onSuccess: {
                
                self.error = "Your account has been created successfully!"
                self.alert.toggle()
                viewModel.fullname = ""
                viewModel.email = ""
                viewModel.password = ""
                viewModel.phone = ""
                confirmPassword = ""
                return

            })

            
                            
        }
        else{
            
            self.error = "Please fill all the contents properly"
            self.alert.toggle()

        }
    }

    
}

struct ErrorView : View {
    
    @State var color = Color.black.opacity(0.7)
    @Binding var alert : Bool
    @Binding var error : String
    
    var body: some View{
        
        GeometryReader{_ in
            
            VStack{
                
                HStack{
                    
                    Text(self.error == "RESET" ? "Message" : "Error")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(self.color)
                    
                    Spacer()
                }
                .padding(.horizontal, 25)
                
                Text(self.error == "RESET" ? "Password reset link has been sent successfully" : self.error)
                .foregroundColor(self.color)
                .padding(.top)
                .padding(.horizontal, 25)
                
                Button(action: {
                    
                    self.alert.toggle()
                    
                }) {
                    
                    Text(self.error == "RESET" ? "Ok" : "Cancel")
                        .foregroundColor(.white)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 120)
                }
                .background(Color("Color"))
                .cornerRadius(10)
                .padding(.top, 25)
                
            }
            .padding(.vertical, 25)
            .frame(width: UIScreen.main.bounds.width - 70)
            .background(Color.white)
            .cornerRadius(15)
        }
        .padding(.horizontal, 35)
        .padding(.top, 140)
        .background(Color.black.opacity(0.35).edgesIgnoringSafeArea(.all))
    }
}
