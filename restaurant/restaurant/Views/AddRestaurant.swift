//
//  AddRestaurant.swift
//  restaurant
//
//  Created by Mac Mini 9 on 18/11/2022.
//

import SwiftUI

struct AddRestaurant: View {
    var body: some View {
        addRestaurant()
    }
}

struct AddRestaurant_Previews: PreviewProvider {
    static var previews: some View {
        AddRestaurant()
    }
}

struct addRestaurant: View{
    @ObservedObject var viewModel = RestaurantModelView()
    @State  private var isShowingDetailView = false
    var body : some View{
            
            VStack{
                
                VStack(alignment: .leading, spacing: 15){
                    
                    Text("Name of the restaurant")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(.gray)

                    TextField("", text: $viewModel.name)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(5)
                        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
                        .shadow(color: Color.black.opacity(0.08), radius: 5, x: 0, y: -5)
                        .font(.system(size: 14))
                    
                    Text("Adress")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(.gray)

                    TextField("Adress", text: $viewModel.Adress)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(5)
                        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
                        .shadow(color: Color.black.opacity(0.08), radius: 5, x: 0, y: -5)
                        .font(.system(size: 14))
                    
                    Text("Phone number")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(.gray)

                    TextField("Phone number", text: $viewModel.phone_number
                    )
                        .padding()
                        .background(Color.white)
                        .cornerRadius(5)
                        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
                        .shadow(color: Color.black.opacity(0.08), radius: 5, x: 0, y: -5)
                        .font(.system(size: 14))
                    
                    Text("Photo")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(.gray)

                    TextField("Photo", text: $viewModel.photo)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(5)
                        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
                        .shadow(color: Color.black.opacity(0.08), radius: 5, x: 0, y: -5)
                        .font(.system(size: 14))
                    
                    Text("Description")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(.gray)

                    TextField("Descriptionn", text: $viewModel.description)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(5)
                        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
                        .shadow(color: Color.black.opacity(0.08), radius: 5, x: 0, y: -5)
                        .font(.system(size: 14))
                    
                }
                .padding(.horizontal, 25)
                .padding(.top, 25)
                
                    
                    Button("Add Restaurant",action: {
                        
                        viewModel.AddRestaurant(restaurant: Restaurant(name: viewModel.name, Adress:viewModel.Adress, phone_number:viewModel.phone_number, photo: viewModel.photo,description: viewModel.description,rating: viewModel.rating), onSuccess: {isShowingDetailView = true} )

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
