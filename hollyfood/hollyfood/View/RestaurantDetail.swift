//
//  RestaurantDetail.swift
//  hollyfood
//
//  Created by AlaBenRejab on 1/1/2023.
//

import SwiftUI

struct RestaurantDetail: View {
    @ObservedObject var viewModel=RestaurantModelView()
    @ObservedObject var ratingViewModel=RatingModelView()
    @State private var quantity = 0
    @State var resto : RestaurantElement
    @State var heart = "heart.fill"
    @State var isPressedButton :Bool=false
    @State private var showingPopover = false
    @State var selected = -1
    @State var numberOfStars :Int = 5
    var placeHolder = "Test it"
    @State var goToMenu = false
    @State var goToOrderHistory = false
    @State var type : String = "restaurant"
    
    @State var userID:String = UserViewModel.session?.id ?? ""

    var body: some View {
            VStack {
                ScrollView(.vertical, showsIndicators: false, content: {
                    GeometryReader{reader in
                        Image(resto.photo)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                        
                            .offset(y: -reader.frame(in: .global).minY)
                        // going to add parallax effect....
                            .frame(width: UIScreen.main.bounds.width, height:  reader.frame(in: .global).minY + 300)
                        
                    }
                    .frame(height: 280)
                    
                    VStack(alignment: .leading,spacing: 15){
                        
                        Text(resto.name)
                            .font(.system(size: 35, weight: .bold))
                        
                        
                        HStack(spacing: 10){
                            
                            ForEach(1..<6){_ in
                                
                                Image(systemName: "star.fill")
                                    .font(.system(size: 18))

                                    .foregroundColor(.yellow)
                            }
                            
                            Spacer()
                            Button("Rate Here"){
                                showingPopover=true
                            }
                            .popover(isPresented: $showingPopover){
                                VStack{
                                    if (self.selected != -1) {

                                    }
                                    HStack(spacing:10,content:{
                                        ForEach(1..<6){i in
                                            Image(systemName: "star.fill").resizable().frame(width: 30,height: 30).foregroundColor(self.selected >= i ? .yellow : Color("GrayColor")).onTapGesture {
                                                self.selected = i
                                                self.numberOfStars=i
                                            }
                                        }
                                        Button("Add Rating",action: {
                                            ratingViewModel.AddRate(creator: "63aee60f474f9d9c423fd7e6", restaurant: resto.id, rating: self.numberOfStars)
                                            
                                         })
                                    })
                                }
                            }
                            .multilineTextAlignment(.leading)
                            .foregroundColor(Color(#colorLiteral(red: 0.9580881, green: 0.10593573, blue: 0.3403331637, alpha: 1)))
                            .padding(.trailing, 20)
                        }
                        
                        HStack {
                            Text(placeHolder)
                                .font(.caption)
                                .foregroundColor(Color("GrayColor"))
                                .padding(.top,5)
                            Spacer()
                            
                            Button(action: {
                                withAnimation(.spring(dampingFraction: 0.5)) {
                                    heart = "heart"
                                }
                            }, label: {
                                Image(systemName: heart)
                                    .font(.largeTitle)
                                    .foregroundColor(.red)
                                
                            })
                            .padding(.all, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                        }
                        
                        
                        Text("Description")
                            .font(.system(size: 25, weight: .bold))
                        
                        Text(resto.description)
                            .padding(.top, 10)
                            .fixedSize(horizontal: false, vertical: true)
                        
                        
                    }
                    .padding(.top, 25)
                    .padding(.horizontal)
                    .background(Color("LightColor"))
                    .cornerRadius(20)
                    .offset(y: -35)
                })
                
                if resto.user == userID
                {
                    HStack(){
                        
                        NavigationLink(destination: Review(numberOfStars: numberOfStars, item: resto),isActive: $isPressedButton){
                            Button(action: {isPressedButton=true}, label: {
                                Text("Comments")
                                    .font(.system(size: 20))
                                    .foregroundColor(Color("LightColor"))
                                    .fontWeight(.bold)
                                    .padding(.vertical)
                                    .frame(width: 112, height: 50)
                                    .background(
                                        LinearGradient(gradient: .init(colors: [Color("PrimaryColor"), Color("PrimaryColor")]), startPoint: .topLeading, endPoint: .bottomTrailing)
                                    )
                                
                            }).onTapGesture {
                                let defaults=UserDefaults.standard
                                defaults.set(resto.id, forKey: "id")
                            }
                            .cornerRadius(8)
                            .padding(.horizontal, 5)

                        }

                        NavigationLink(destination: Menu(restaurant: $resto).navigationBarBackButtonHidden(false), isActive: $goToMenu) {
                            
                            Button(action: {
                                goToMenu=true
                            })
                            {
                                Text("Menu")
                                    .font(.system(size: 20))
                                    .foregroundColor(Color("LightColor"))
                                    .fontWeight(.bold)
                                    .padding(.vertical)
                                    .frame(width: 112, height: 50)
                                    .background(
                                        LinearGradient(gradient: .init(colors: [Color("PrimaryColor"), Color("PrimaryColor")]), startPoint: .topLeading, endPoint: .bottomTrailing)
                                    )
                                
                            }
                            .cornerRadius(8)
                            .padding(.horizontal, 5)

                            
                        }
                        

                        NavigationLink(destination: OrderHistory(type: $type, id: $resto.id)
                            .navigationBarBackButtonHidden(false), isActive: $goToOrderHistory) {
                            
                            Button(action: {
                                goToOrderHistory=true
                            })
                            {
                                Text("Orders")
                                    .font(.system(size: 20))
                                    .foregroundColor(Color("LightColor"))
                                    .fontWeight(.bold)
                                    .padding(.vertical)
                                    .frame(width: 112, height: 50)
                                    .background(
                                        LinearGradient(gradient: .init(colors: [Color("PrimaryColor"), Color("PrimaryColor")]), startPoint: .topLeading, endPoint: .bottomTrailing)
                                    )

                            }
                            .cornerRadius(8)
                            .padding(.horizontal, 5)

                        }
                    }
                    .edgesIgnoringSafeArea(.all)
                    .background(Color("LightColor").edgesIgnoringSafeArea(.all))
                }
                else
                {
                    HStack(){
                        
                        NavigationLink(destination: Review(numberOfStars: numberOfStars, item: resto),isActive: $isPressedButton){
                            Button(action: {isPressedButton=true}, label: {
                                Text("Comments")
                                    .font(.system(size: 20))
                                    .foregroundColor(Color("LightColor"))
                                    .fontWeight(.bold)
                                    .padding(.vertical)
                                    .frame(width: 112, height: 50)
                                    .background(
                                        LinearGradient(gradient: .init(colors: [Color("PrimaryColor"), Color("PrimaryColor")]), startPoint: .topLeading, endPoint: .bottomTrailing)
                                    )

                            }).onTapGesture {
                                let defaults=UserDefaults.standard
                                defaults.set(resto.id, forKey: "id")
                            }
                            .cornerRadius(8)
                            .padding(.horizontal, 5)

                        }

                        NavigationLink(destination: Menu(restaurant: $resto).navigationBarBackButtonHidden(false), isActive: $goToMenu) {
                            
                            Button(action: {
                                goToMenu=true
                            })
                            {
                                Text("Menu")
                                    .font(.system(size: 20))
                                    .foregroundColor(Color("LightColor"))
                                    .fontWeight(.bold)
                                    .padding(.vertical)
                                    .frame(width: 112, height: 50)
                                    .background(
                                        LinearGradient(gradient: .init(colors: [Color("PrimaryColor"), Color("PrimaryColor")]), startPoint: .topLeading, endPoint: .bottomTrailing)
                                    )
                                
                            }
                            .cornerRadius(8)
                            .padding(.horizontal, 5)

                            
                        }
                    }
                    .edgesIgnoringSafeArea(.all)
                    .background(Color("LightColor").edgesIgnoringSafeArea(.all))

                }
                
                
            }.onAppear(perform:{
                viewModel.getRestrauant()
                print("restaurant user id: "+resto.user)
                print("user id: "+userID)

            })
        
    }
    
    struct RestaurantDetail_Previews: PreviewProvider {
        static var previews: some View {
            Tab()
        }
    }
}
