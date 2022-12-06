//
//  MyRestaurants.swift
//  hollyfood
//
//  Created by Khairi on 18/11/2022.
//

import SwiftUI

struct MyRestaurants: View {
    
    @ObservedObject var viewModel = PlateViewModel()
    @State var t = false
    
    var body: some View {
        
        VStack{
            Text("My Restaurant")
            
            NavigationLink(destination: Menu().navigationBarBackButtonHidden(false), isActive: $t) {
                
                Button(action: {
                    t=true
                })
                {
                    Text("See Menu")
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

                
            }.padding()

        }
        



    }
}

struct MyRestaurants_Previews: PreviewProvider {
    static var previews: some View {
        MyRestaurants()
    }
}

