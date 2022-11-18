//
//  Authentification.swift
//  hollyfood
//
//  Created by Khairi on 16/11/2022.
//

import SwiftUI

struct Authentification: View {
    var body: some View {
        Home()
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
    @State private var isShowingDetailView = false
    
    var body : some View{
        
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

                TextField("password", text: $viewModel.password)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(5)
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
                    .shadow(color: Color.black.opacity(0.08), radius: 5, x: 0, y: -5)
                
                Button(action: {}) {
                    Text("Forget Password")
                        .font(.system(size: 14))
                        .fontWeight(.bold)
                        .foregroundColor(Color("Color"))
                }
                .padding(.top, 10)
        
            }
            .padding(.horizontal, 25)
            .padding(.top, 25)
            
            
                
                Button("Login",action: {
                    
                    viewModel.LogIn(email: viewModel.email , password:viewModel.password , onSuccess: {isShowingDetailView = true} , onError: {
                        (errorMessage)in
                    })
                    
                })
                .font(.system(size: 20))
                .foregroundColor(.white)
                .fontWeight(.bold)
                .padding(.vertical)
                .frame(width: UIScreen.main.bounds.width - 50)
                .background(
                    LinearGradient(gradient: .init(colors: [Color("Color"), Color("Color 1")]), startPoint: .topLeading, endPoint: .bottomTrailing)
                )
                .cornerRadius(8)
                .padding(.horizontal, 25)
                .padding(.top, 25)
                
            
            
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

struct SignUp: View{
    
    @ObservedObject var viewModel = UserViewModel()
    @State private var isShowingDetailView = false

    
    var body : some View{
        
        VStack{
            
            VStack(alignment: .leading, spacing: 15){
                
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
                    .font(.system(size: 14))
                
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
                    .font(.system(size: 14))
                
                Text("Password")
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(.gray)

                TextField("password", text: $viewModel.password)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(5)
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
                    .shadow(color: Color.black.opacity(0.08), radius: 5, x: 0, y: -5)
                    .font(.system(size: 14))
                
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
                    .font(.system(size: 14))
                
            }
            .padding(.horizontal, 25)
            .padding(.top, 25)
            
                
                Button("Sign Up",action: {
                    
                    viewModel.SignUp(user: User(fullname: viewModel.fullname, email:viewModel.email, password: viewModel.password, phone: viewModel.phone, address: "", role: "Admin"), onSuccess: {isShowingDetailView = true} )

                })
                .font(.system(size: 20))
                .foregroundColor(.white)
                .fontWeight(.bold)
                .padding(.vertical)
                .frame(width: UIScreen.main.bounds.width - 50)
                .background(
                    LinearGradient(gradient: .init(colors: [Color("Color"), Color("Color 1")]), startPoint: .topLeading, endPoint: .bottomTrailing)
                )
                .cornerRadius(8)
                .padding(.horizontal, 15)
                .padding(.top, 10)
                
            

            
            Button(action: {}) {
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
            .padding(.top, 10)
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




