//
//  MyRestaurantsView.swift
//  hollyfood
//
//  Created by AlaBenRejab on 2/1/2023.
//

import SwiftUI

struct MyRestaurantsView: View {
    @State var hero = false
    @ObservedObject var RestaurantViewModel=RestaurantModelView()
    @State var expand = false
    @State var searchQuery = ""
     var long:String = ""
     var lat:String = ""
    
    @State var userID:String = UserViewModel.session?.id ?? ""
    @State var goToAddRestaurant : Bool = false
    
    var body: some View {
        
            VStack {

                HStack(spacing: 15) {
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 23, weight: .bold))
                        .foregroundColor(Color("GrayColor"))

                    TextField("Search", text: $searchQuery)
                }
                .padding(.vertical, 10)
                .padding(.horizontal)
                .background(Color("DarkColor").opacity(0.05))
                .cornerRadius(8)
                .padding()
                .padding(.top, 55)

                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                       //Our picks
                        VStack{
                            HStack {
                                Text("My Restaurants")
                                    .bold()
                                    .multilineTextAlignment(.trailing)
                                    .padding(.leading, 20)
                                    .foregroundColor(Color("DarkColor"))

                                
                                Spacer()
                                
                                
                                NavigationLink(destination: AddRestaurant(), isActive: $goToAddRestaurant){
                                  
                                    
                                    Button("Add Restaurant",action: {
                                        goToAddRestaurant=true
                                     })
                                    .multilineTextAlignment(.leading)
                                    .foregroundColor(Color("PrimaryColor"))
                                    .padding(.trailing, 20)

                                }


                                /*Text("Add Restaurant >")
                                    .multilineTextAlignment(.leading)
                                    .foregroundColor(Color("PrimaryColor"))
                                    .padding(.trailing, 20)*/
                            }
                            .opacity(self.hero ? 0 : 1)
                            
                            
                            // Card View
                            VStack(spacing: 50) {
                                                                
                                ForEach(searchQuery == "" ? RestaurantViewModel.restaurants : RestaurantViewModel.restaurants.filter{$0.name.lowercased().contains(searchQuery.lowercased())})
                                {restaurant in
                                    GeometryReader{g in
                                        NavigationLink(
                                            destination: RestaurantDetail(resto :restaurant),
                                            label: {
                                        
                                        OurPicks(card: restaurant, hero: self.$hero)
                                        
                                            .offset(y: self.expand ? -g.frame(in: .global).minY : 0)
                                            .opacity(self.hero ? (self.expand ? 1 : 0) : 1)
                                            .onTapGesture {
                                                print(restaurant.id)
                                            }
                                            })
                                        .buttonStyle(PlainButtonStyle())
                                        
                                    }
                                    // going to increase height based on expand...
                                    .frame(height: self.expand ? UIScreen.main.bounds.height : 250)
                                    .simultaneousGesture(DragGesture(minimumDistance: self.expand ? 0 : 800).onChanged({ (_) in
                                        
                                        print("dragging")
                                    }))
                                }
                            }
                            
                        }.onAppear(perform:{
                            RestaurantViewModel.getMyRestrauants(user: userID)
                        })
                        
                    }.padding(.top, 10)
                    
                    Spacer()
                    
                    
                }
                .padding(.bottom, 50)

            }
            .edgesIgnoringSafeArea(.top)

            
            
        
    }
}

struct MyRestaurantsView_Previews: PreviewProvider {
    static var previews: some View {
        Tab()
    }
}
