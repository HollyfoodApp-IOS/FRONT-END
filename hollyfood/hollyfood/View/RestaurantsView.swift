//
//  RestaurantsView.swift
//  hollyfood
//
//  Created by AlaBenRejab on 1/1/2023.
//

import SwiftUI

struct RestaurantsView: View {
    @State var hero = false
    @ObservedObject var RestaurantViewModel=RestaurantModelView()
    @State var expand = false
     var long:String = ""
     var lat:String = ""
    @State var searchQuery = ""

    @State var userID:String = UserViewModel.session?.id ?? ""

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
                    
                    //TrendingWeek

                    VStack{
                        
                        HStack {
                            Text("Near You")
                                .bold()
                                .multilineTextAlignment(.trailing)
                                .padding(.top, 20)
                                .padding(.leading, 20)
                            
                            Spacer()
                        }
                        .opacity(self.hero ? 0 : 1)

                        // Card View
                        

                        ScrollView(.horizontal, showsIndicators: false) {

                            HStack {
                                
                                ForEach(RestaurantViewModel.restaurants) { card in
                                    NavigationLink(
                                        destination: RestaurantDetail(resto :card),
                                        label: {
                                            TrendingWeek(resto: card)
                                                .background(Color("LightColor"))
                                                .cornerRadius(15)
                                                .shadow(radius: 1)
                                        })
                                    .buttonStyle(PlainButtonStyle())
                                }.onAppear(perform: {
                                    RestaurantViewModel.getRestrauantNearMe(long:long, lat:lat)
                                    
                                })
                                .padding(.bottom, 5)
                                .padding(.leading, 30)

                                
                            }
                        }
                    }.padding(.top, -20)
                        .opacity(self.hero ? 0 : 1)
                    
                    
                    //Categories
                    VStack{
                        HStack {
                            /*Text("Categories")
                                .bold()
                                .multilineTextAlignment(.trailing)
                                .padding(.leading, 20)*/
                            
                            Spacer()
                        }
                        // Categories View
                        HStack(spacing: 10) {
                            ForEach(1 ..< 5) { i in
                                VStack {
                                    Image("categ-\(String(i))")
                                    Text(FoodTypes[Int(i)-1])
                                        .font(.subheadline)
                                        .foregroundColor(Color("DarkColor"))
                                        .bold()
                                }
                                .frame(width: 80, height: 100, alignment: .center)
                                .background(Color("LightColor"))
                                .cornerRadius(15)
                            }
                        }
                        
                        HStack(spacing: 10) {
                            ForEach(3 ..< 7) { i in
                                VStack {
                                    Image("categ-\(String(i))")
                                    Text(FoodTypes[Int(i)-1])
                                        .font(.subheadline)
                                        .foregroundColor(Color("DarkColor"))
                                        .bold()
                                }
                                .frame(width: 80, height: 100, alignment: .center)
                                .background(Color("LightColor"))
                                .cornerRadius(15)
                            }
                        }
                        
                    }
                    .shadow(radius: 1)
                    .opacity(self.hero ? 0 : 1)

                    
                    
                    //Our picks
                    VStack{
                        HStack {
                            Text("Restaurants list")
                                .bold()
                                .multilineTextAlignment(.trailing)
                                .padding(.top, 20)
                                .padding(.leading, 20)
                            
                            Spacer()
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
                        
                    }.onAppear(perform:RestaurantViewModel.getAllRestrauants)
                    
                }.padding(.top, 10)
                
                Spacer()
                
                
            }
            .padding(.bottom, 50)

        }
        .edgesIgnoringSafeArea(.top)

        
            /*VStack {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        SearchBar()
                        
                        //TrendingWeek
                        
                        VStack{
                            HStack {
                                Text("Near You")
                                    .bold()
                                    .multilineTextAlignment(.trailing)
                                    .padding(.leading, 20)
                                
                                Spacer()
                                Text("View all >")
                                    .multilineTextAlignment(.leading)
                                    .foregroundColor(Color(#colorLiteral(red: 0.9580881, green: 0.10593573, blue: 0.3403331637, alpha: 1)))
                                    .padding(.trailing, 20)
                            }
                            // Card View
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack {
                                    ForEach(RestaurantViewModel.restaurants) { card in
                                        NavigationLink(
                                            destination: RestaurantDetail(resto :card),
                                            label: {
                                                TrendingWeek(resto: card)
                                                    .background(Color.white)
                                                    .cornerRadius(15)
                                                    .shadow(radius: 1)
                                            })
                                        .buttonStyle(PlainButtonStyle())
                                    }.onAppear(perform: {
                                        RestaurantViewModel.getRestrauantNearMe(long:long, lat:lat)
                                        
                                    })
                                    .padding(.bottom, 10)
                                    .padding(.leading, 30)

                                    
                                }
                            }
                        }.padding(.top, -50)
                            .opacity(self.hero ? 0 : 1)
                        
                        
                        //Categories
                        VStack{
                            HStack {
                                Text("Categories")
                                    .bold()
                                    .multilineTextAlignment(.trailing)
                                    .padding(.leading, 20)
                                
                                Spacer()
                            }
                            // Categories View
                            HStack(spacing: 10) {
                                ForEach(1 ..< 5) { i in
                                    VStack {
                                        Image("categ-\(String(i))")
                                        Text(FoodTypes[Int(i)-1])
                                            .font(.subheadline)
                                            .bold()
                                    }
                                    .frame(width: 80, height: 100, alignment: .center)
                                    .background(Color.white)
                                    .cornerRadius(15)
                                }
                            }
                            
                            HStack(spacing: 10) {
                                ForEach(3 ..< 7) { i in
                                    VStack {
                                        Image("categ-\(String(i))")
                                        Text(FoodTypes[Int(i)-1])
                                            .font(.subheadline)
                                            .bold()
                                    }
                                    .frame(width: 80, height: 100, alignment: .center)
                                    .background(Color.white)
                                    .cornerRadius(15)
                                }
                            }
                            
                        }
                        .shadow(radius: 1)
                        .opacity(self.hero ? 0 : 1)
                        
                        //Our picks
                        VStack{
                            HStack {
                                Text("Our picks")
                                    .bold()
                                    .multilineTextAlignment(.trailing)
                                    .padding(.leading, 20)
                                
                                Spacer()
                                Text("View all >")
                                    .multilineTextAlignment(.leading)
                                    .foregroundColor(Color(#colorLiteral(red: 0.9580881, green: 0.10593573, blue: 0.3403331637, alpha: 1)))
                                    .padding(.trailing, 20)
                            }
                            .opacity(self.hero ? 0 : 1)
                            
                            
                            // Card View
                            VStack(spacing: 100) {
                                ForEach(RestaurantViewModel.restaurants)  {restaurant in
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
                            
                        }.onAppear(perform:RestaurantViewModel.getAllRestrauants)
                        
                    }.padding(.top, 50)
                        .padding(.bottom, 150)
                    
                    Spacer()
                    
                    
                }
                .background(Color(#colorLiteral(red: 0.9843164086, green: 0.9843164086, blue: 0.9843164086, alpha: 1)))
                
            }.background(Color(#colorLiteral(red: 0.9580881, green: 0.10593573, blue: 0.3403331637, alpha: 1)))
                .edgesIgnoringSafeArea(.top)*/
            
            
            
        
    }
}



struct SearchBar: View {
    @State var search = ""
    var body: some View {
        
        ZStack {
            
            LinearGradient(gradient: Gradient(colors: [Color("PrimaryColor"), Color(#colorLiteral(red: 0.9843164086, green: 0.9843164086, blue: 0.9843164086, alpha: 1))]), startPoint: .top, endPoint: .bottom)
                .frame(width: UIScreen.main.bounds.width, height: (UIScreen.main.bounds.height)*0.25, alignment: .center)
                .edgesIgnoringSafeArea(.all)
            
            
            VStack {
                HStack {
                    Text("Browse")
                        .bold()
                        .font(.title)
                        .multilineTextAlignment(.trailing)
                        .foregroundColor(.white)
                        .padding(.leading, 20)
                        .padding(.top, -40)
                    Spacer()
                    Text("Filter")
                        .font(.title2)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(.white)
                        .padding(.trailing, 20)
                        .padding(.top, -30)
                }
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                        .font(.title)
                    TextField("Search...", text: $search)
                        
                        .font(.title3)
                }
                .frame(width:  ( UIScreen.main.bounds.width)*0.85, height: 40, alignment: .leading)
                .padding(.leading, 20)
                .background(Color.white)
                .cornerRadius(10)
                
            }
        }
    }
    
    struct RestaurantsView_Previews: PreviewProvider {
        static var previews: some View {
            Tab()
        }
    }
}

var FoodTypes = ["Pizza","Drinks","Tacos","Burger","Fries","Top"]

