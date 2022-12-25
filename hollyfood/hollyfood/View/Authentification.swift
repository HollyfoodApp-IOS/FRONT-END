//
//  Authentification.swift
//  hollyfood
//
//  Created by Khairi on 16/11/2022.
//

import SwiftUI
import GoogleSignIn
import LocalAuthentication

struct Authentification: View {
    
    @State private var unlocked = false
    
    @ObservedObject var translation = Translation()
    @State var back : String = ""

    var body: some View {
                
        NavigationView()
        {
            Home()
                .navigationTitle(back)
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarHidden(true)
        }
        .onAppear(perform: {
            translation.Translate()
            back = translation.back
        })
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
    
    @ObservedObject var translation = Translation()
    @State var Login : String = ""
    @State var Sign_Up : String = ""

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
                        Text(Login)
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
                        Text(Sign_Up)
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
                hollyfood.Login()
            }
            else
            {
                SignUp()
            }
            
            Spacer()
        }
        .onAppear(perform: {
            
            translation.Translate()
            Login = translation.Login
            Sign_Up = translation.Sign_Up
        })

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
    @AppStorage("lastUserEmail") var lastUserEmail: String = ""
    @AppStorage("lastUserPassword") var lastUserPassword: String = ""
    
    @ObservedObject var translation = Translation()
    @State var Login : String = ""
    @State var Email : String = ""
    @State var Enter_Email : String = ""
    @State var Password : String = ""
    @State var Enter_Password : String = ""
    @State var Forgot_Password : String = ""
    @State var Verify_Account : String = ""
    @State var Login_With_FaceID : String = ""
    @State var Error : String = ""
    @State var Invalid_email_or_password : String = ""
    @State var Account_not_verified_yet : String = ""
    @State var fieldsEmptyMessage : String = ""
    @State var No_user_has_previously_logged_in : String = ""
    @State var There_is_no_Face_ID_saved_in_the_phone : String = ""

    var body : some View{
        
        ZStack{
            
            ZStack(alignment: .topTrailing) {
                
                GeometryReader{_ in
                    
                    VStack{
                        
                        VStack(alignment: .leading, spacing: 15){
                            
                            Text(Email)
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundColor(Color("GrayColor"))
                            
                            TextField(Enter_Email , text: $userViewModel.email)
                                .padding()
                                .background(Color("LightColor"))
                                .cornerRadius(5)
                                .shadow(color: Color("DarkColor").opacity(0.1), radius: 5, x: 0, y: 5)
                                .shadow(color: Color("DarkColor").opacity(0.08), radius: 5, x: 0, y: -5)
                            
                            Text(Password)
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundColor(Color("GrayColor"))
                            
                            HStack(spacing: 15){
                                
                                VStack{
                                    
                                    if self.visible{
                                        
                                        TextField(Enter_Password, text: $userViewModel.password)
                                            .autocapitalization(.none)
                                    }
                                    else{
                                        
                                        SecureField(Enter_Password, text: $userViewModel.password)
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
                                        Text(Forgot_Password)
                                            .font(.system(size: 14))
                                            .fontWeight(.bold)
                                            .foregroundColor(Color("PrimaryColor"))
                                    }
                                    .padding(.top, 10)

                                }
                                
                                NavigationLink(destination: VerifyAccount(), isActive: $verifyAccount){
                                    
                                    Button(action: {verifyAccount=true }) {
                                        Text(Verify_Account)
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
                                Text(Login)
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
                        
                        Button(action: {
                            loginWithFaceID()
                        }) {
                            HStack(spacing: 35){
                                Image(systemName: "faceid")
                                    .font(.system(size: 26))
                                    .foregroundColor(Color("PrimaryColor"))
                                
                                Text(Login_With_FaceID)
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
                    .onAppear(perform: {
                        
                        translation.Translate()
                        Login = translation.Login
                        Email = translation.Email
                        Enter_Email = translation.Enter_Email
                        Password = translation.Password
                        Enter_Password = translation.Enter_Password
                        Forgot_Password = translation.Forgot_Password
                        Verify_Account = translation.Verify_Account
                        Login_With_FaceID = translation.Login_With_FaceID
                        Error = translation.Error
                        Invalid_email_or_password = translation.Invalid_email_or_password
                        Account_not_verified_yet = translation.Account_not_verified_yet
                        fieldsEmptyMessage = translation.fieldsEmptyMessage
                        No_user_has_previously_logged_in = translation.No_user_has_previously_logged_in
                        There_is_no_Face_ID_saved_in_the_phone = translation.There_is_no_Face_ID_saved_in_the_phone

                    })

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
                if(message == "Invalid email or password")
                {
                    self.title = Error
                    self.message = Invalid_email_or_password
                    self.alert.toggle()
                    print(isLogin)
                    return
                }
                else if(message == "Account not verified yet")
                {
                    self.title = Error
                    self.message = Account_not_verified_yet
                    self.alert.toggle()
                    print(isLogin)
                    return
                }
                else
                {
                    lastUserEmail = userViewModel.email
                    lastUserPassword = userViewModel.password
                    isLogin = true
                }
                
            })

        }
        else{
            self.title = Error
            self.message = fieldsEmptyMessage
            self.alert.toggle()
        }
    }
    
    func loginWithFaceID(){
        
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error){
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "This is for security reasons"){ success,
                AuthentificationError in
                
                if success{
                    
                    if lastUserEmail != "" && lastUserPassword != ""
                    {
                        userViewModel.LogIn(email: lastUserEmail , password: lastUserPassword, onSuccess: {(message) in
                                isLogin = true
                        })

                    }
                    else
                    {
                        self.title = Error
                        self.message = No_user_has_previously_logged_in
                        self.alert.toggle()
                        return

                    }
                }
                
            }
        }
        else
        {
            self.title = Error
            self.message = There_is_no_Face_ID_saved_in_the_phone
            self.alert.toggle()
            return

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
    @State var color = Color("DarkColor").opacity(0.7)
    @State var selectedRole = ""
    
    @ObservedObject var translation = Translation()
    @State var Full_Name : String = ""
    @State var Enter_Full_Name : String = ""
    @State var Email : String = ""
    @State var Enter_Email : String = ""
    @State var Password : String = ""
    @State var Enter_Password : String = ""
    @State var Confirm_Password : String = ""
    @State var Phone_Number : String = ""
    @State var Enter_Phone_Number : String = ""
    @State var Role : String = ""
    @State var Sign_Up : String = ""
    @State var Error : String = ""
    @State var Message : String = ""
    @State var fullNameVerification : String = ""
    @State var passwordVerification : String = ""
    @State var confirmPasswordVerification : String = ""
    @State var phoneNumberVerification : String = ""
    @State var roleVerification: String = ""
    @State var accountCreatedMessage : String = ""
    @State var fieldsEmptyMessage : String = ""

    var body : some View{
        
        ZStack{
            
            ZStack(alignment: .topTrailing) {
                
                GeometryReader{_ in
                    
                    VStack{
    
                        VStack(alignment: .leading, spacing: 8){
                            
                            Text(Full_Name)
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundColor(Color("GrayColor"))

                            TextField(Enter_Full_Name, text: $userViewModel.fullname)
                                .padding()
                                .background(Color("LightColor"))
                                .cornerRadius(5)
                                .shadow(color: Color("DarkColor").opacity(0.1), radius: 5, x: 0, y: 5)
                                .shadow(color: Color("DarkColor").opacity(0.08), radius: 5, x: 0, y: -5)
                                .font(.system(size: 12))
                            
                            Text(Email)
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundColor(Color("GrayColor"))

                            TextField(Enter_Email, text: $userViewModel.email)
                                .padding()
                                .background(Color("LightColor"))
                                .cornerRadius(5)
                                .shadow(color: Color("DarkColor").opacity(0.1), radius: 5, x: 0, y: 5)
                                .shadow(color: Color("DarkColor").opacity(0.08), radius: 5, x: 0, y: -5)
                                .font(.system(size: 12))
                            
                            Text(Password)
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundColor(Color("GrayColor"))

                            HStack(spacing: 15){
                                
                                VStack{
                                    
                                    if self.visible{
                                        
                                        TextField(Enter_Password, text: $userViewModel.password)
                                            .autocapitalization(.none)
                                    }
                                    else{
                                        
                                        SecureField(Enter_Password, text: $userViewModel.password)
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
                            
                            Text(Confirm_Password)
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundColor(Color("GrayColor"))

                            HStack(spacing: 15){
                                
                                VStack{
                                    
                                    if self.visible2{
                                        
                                        TextField(Confirm_Password, text: $confirmPassword)
                                            .autocapitalization(.none)
                                    }
                                    else{
                                        
                                        SecureField(Confirm_Password, text: $confirmPassword)
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

                            
                            Text(Phone_Number)
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundColor(Color("GrayColor"))

                            TextField(Enter_Phone_Number, text: $userViewModel.phone)
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
                            Text(Role)
                                 .font(.caption)
                                 .fontWeight(.bold)
                                 .foregroundColor(Color("GrayColor"))

                            Picker(Role, selection: $selectedRole){
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
                                
                                Text(Sign_Up)
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
                    .onAppear(perform: {
                        
                        translation.Translate()
                        Full_Name = translation.Full_Name
                        Enter_Full_Name = translation.Enter_Full_Name
                        Email = translation.Enter_Email
                        Enter_Email = translation.Enter_Email
                        Password = translation.Password
                        Enter_Password = translation.Enter_Password
                        Confirm_Password = translation.Confirm_Password
                        Phone_Number = translation.Phone_Number
                        Enter_Phone_Number = translation.Enter_Phone_Number
                        Role = translation.Role
                        Sign_Up = translation.Sign_Up
                        Error = translation.Error
                        Message = translation.Message
                        fullNameVerification = translation.fullNameVerification
                        passwordVerification = translation.passwordVerification
                        confirmPasswordVerification = translation.confirmPasswordVerification
                        phoneNumberVerification = translation.phoneNumberVerification
                        roleVerification = translation.roleVerification
                        accountCreatedMessage = translation.accountCreatedMessage
                        fieldsEmptyMessage = translation.fieldsEmptyMessage

                    })

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
                
                self.title = Error
                self.message = fullNameVerification
                self.alert.toggle()
                return
            }
            
            if userViewModel.password.count < 3 {
                
                self.title = Error
                self.message = passwordVerification
                self.alert.toggle()
                return
            }
            
            if userViewModel.phone.count != 8 {
                
                self.title = Error
                self.message = phoneNumberVerification
                self.alert.toggle()
                return
            }
                        
            if userViewModel.password != confirmPassword {
                
                self.title = Error
                self.message = confirmPasswordVerification
                self.alert.toggle()
                return
            }
                
            if selectedRole == "" {
                
                self.title = Error
                self.message =  roleVerification
                self.alert.toggle()
                return
            }

            userViewModel.SignUp(user: User(id: "", fullname: userViewModel.fullname, email:userViewModel.email, password: userViewModel.password, phone: userViewModel.phone, role: selectedRole), onSuccess: {
                
                self.title = Message
                self.message = accountCreatedMessage
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
            
            self.title = Error
            self.message = fieldsEmptyMessage
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
