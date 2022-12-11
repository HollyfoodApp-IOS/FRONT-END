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
    
    @State var restaurant : String = "639644dd4e82d5cf69df69de"
    @State var restaurantName : String = "Comme Chez Toi"
    @State var type : String = "restaurant"
    

    var body: some View {
        
        VStack{
            Text("My Restaurant")
            
            NavigationLink(destination: Menu(restaurant: $restaurant, restaurantName: $restaurantName).navigationBarBackButtonHidden(false), isActive: $goToMenu) {
                
                Button(action: {
                    goToMenu=true
                })
                {
                    Text("See Menu")
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
            
            NavigationLink(destination:
            //rderHistory()
           OrderHistory(type: $type, id: $restaurant)
            //dd()
                .navigationBarBackButtonHidden(false), isActive: $goToOrderHistory) {
                
                Button(action: {
                    goToOrderHistory=true
                })
                {
                    Text("See Orders")
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
    }
}

struct MyRestaurants_Previews: PreviewProvider {
    static var previews: some View {
        MyRestaurants()
    }
}

