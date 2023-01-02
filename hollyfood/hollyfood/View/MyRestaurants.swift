//
//  MyRestaurants.swift
//  hollyfood
//
//  Created by Khairi on 18/11/2022.
//

import SwiftUI

struct MyRestaurants: View {
    
    @ObservedObject var viewModel = PlateViewModel()

    @State var goToMenu = false
    @State var goToOrderHistory = false
    
    //@State var restaurant : String = "639644dd4e82d5cf69df69de"
    //@State var restaurantName : String = "Comme Chez Toi"
    @State var type : String = "restaurant"

    @ObservedObject var translation = Translation()
    @State var My_Restaurants : String = ""
    @State var See_Menu : String = ""
    @State var See_Orders : String = ""
    @State var restaurant : RestaurantElement = RestaurantElement(id: "1", name: "Restaurant", Adresse: "1", phone_number: "1", totalrating: "5", photo: "1", description: "1", user: "1")

    var body: some View {
    
        VStack{
            
            Text(My_Restaurants)
            
            NavigationLink(destination: Menu(restaurant: $restaurant).navigationBarBackButtonHidden(false), isActive: $goToMenu) {
                
                Button(action: {
                    goToMenu=true
                })
                {
                    Text(See_Menu)
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 200)
                        .background(
                            LinearGradient(gradient: .init(colors: [Color("PrimaryColor"), Color("PrimaryColor")]), startPoint: .topLeading, endPoint: .bottomTrailing)
                        )
                    
                }
                .cornerRadius(8)
                .padding(.horizontal, 25)
                .padding(.top, 25)
                
            }.padding()
            
            NavigationLink(destination: OrderHistory(type: $type, id: $restaurant.id)
                .navigationBarBackButtonHidden(false), isActive: $goToOrderHistory) {
                
                Button(action: {
                    goToOrderHistory=true
                })
                {
                    Text(See_Orders)
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 200)
                        .background(
                            LinearGradient(gradient: .init(colors: [Color("PrimaryColor"), Color("PrimaryColor")]), startPoint: .topLeading, endPoint: .bottomTrailing)
                        )
                    
                }
                .cornerRadius(8)
                .padding(.horizontal, 25)

            }.padding()

        }
        .onAppear(perform: {
            
            translation.Translate()
            My_Restaurants = translation.My_Restaurants
            See_Menu = translation.See_Menu
            See_Orders = translation.See_Orders

        })

    }
}

struct MyRestaurants_Previews: PreviewProvider {
    static var previews: some View {
        MyRestaurants()
    }
}


