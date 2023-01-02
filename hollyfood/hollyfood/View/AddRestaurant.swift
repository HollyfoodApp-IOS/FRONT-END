//
//  AddRestaurant.swift
//  hollyfood
//
//  Created by AlaBenRejab on 2/1/2023.
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
    @State var rating=0
    @State var userID:String = UserViewModel.session?.id ?? ""

    var body : some View{
        
        ZStack{
            
            ZStack(alignment: .topTrailing) {
                
                VStack{
                    
                    GeometryReader{_ in
                        
                        VStack{
                            
                            VStack(alignment: .leading, spacing: 10){
                                
                                
                                Text("Name of the restaurant")
                                    .font(.system(size: 18))
                                    .fontWeight(.bold)
                                    .foregroundColor(Color("GrayColor"))
                                    .padding(.top, 30)
                                
                                TextField("Enter Restaurant", text: $viewModel.name)
                                    .padding()
                                    .background(Color("LightColor"))
                                    .cornerRadius(5)
                                    .shadow(color: Color("DarkColor").opacity(0.1), radius: 5, x: 0, y: 5)
                                    .shadow(color: Color("DarkColor").opacity(0.08), radius: 5, x: 0, y: -5)
                                    .font(.system(size: 20))
                                
                                Text("Adress")
                                    .font(.system(size: 18))
                                    .fontWeight(.bold)
                                    .foregroundColor(Color("GrayColor"))
                                    .padding(.top, 10)
                                
                                TextField("Enter Adress", text: $viewModel.Adresse)
                                    .padding()
                                    .background(Color("LightColor"))
                                    .cornerRadius(5)
                                    .shadow(color: Color("DarkColor").opacity(0.1), radius: 5, x: 0, y: 5)
                                    .shadow(color: Color("DarkColor").opacity(0.08), radius: 5, x: 0, y: -5)
                                    .font(.system(size: 20))

                                
                                Text("Phone number")
                                    .font(.system(size: 18))
                                    .fontWeight(.bold)
                                    .foregroundColor(Color("GrayColor"))
                                    .padding(.top, 10)
                                
                                TextField("Enter Phone number", text: $viewModel.phone_number)
                                    .padding()
                                    .background(Color("LightColor"))
                                    .cornerRadius(5)
                                    .shadow(color: Color("DarkColor").opacity(0.1), radius: 5, x: 0, y: 5)
                                    .shadow(color: Color("DarkColor").opacity(0.08), radius: 5, x: 0, y: -5)
                                    .font(.system(size: 20))

                                Text("Description")
                                    .font(.system(size: 18))
                                    .fontWeight(.bold)
                                    .foregroundColor(Color("GrayColor"))
                                    .padding(.top, 10)
                                
                                TextField("Enter Descriptionn", text: $viewModel.description)
                                    .padding()
                                    .background(Color("LightColor"))
                                    .cornerRadius(5)
                                    .shadow(color: Color("DarkColor").opacity(0.1), radius: 5, x: 0, y: 5)
                                    .shadow(color: Color("DarkColor").opacity(0.08), radius: 5, x: 0, y: -5)
                                    .font(.system(size: 20))
                                                                                        
                                
                            }
                            .padding(.horizontal, 25)
                            .padding(.top, 25)
                            
                            
                            Button(action: {
                                
                                viewModel.AddRestaurant(restaurant: RestaurantElement(id:"",name: viewModel.name, Adresse:viewModel.Adresse, phone_number: viewModel.phone_number, totalrating: viewModel.totalrating,photo:"ddd",description:viewModel.description, user: userID), onSuccess: {isShowingDetailView = true} )

                            })
                            {
                            
                                Text("Add Restaurant")
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
                        .onAppear(perform: {
                            
                        })

                    }
                }
            }
                        
        }
        .navigationTitle("Add Restaurant")
        .navigationBarTitleDisplayMode(.inline)

        
                            
                
                
            }
            
        }
        
    
struct GradientButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(Color.white)
            .padding()
            .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.orange]), startPoint: .leading, endPoint: .trailing))
            .cornerRadius(15.0)
    }
}
