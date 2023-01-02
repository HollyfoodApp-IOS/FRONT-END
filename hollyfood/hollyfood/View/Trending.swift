//
//  Trending.swift
//  hollyfood
//
//  Created by AlaBenRejab on 1/1/2023.
//

import SwiftUI

struct TrendingWeek: View {
    @State var resto : RestaurantElement
    var body: some View {
        
        VStack {
            Image(resto.photo)
                .resizable()
                .frame(width: 270, height: 150)
            
            HStack {
                Text(resto.name)
                    .bold()
                    .padding(.all, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                Spacer()
            }
            
            HStack {
                Text(resto.description)
                    .font(.subheadline)
                    .foregroundColor(Color("GrayColor"))
                    .padding(.leading, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                Spacer()
            }
            
           /* HStack {
                ForEach(0 ..<5 trendingMeal.stars) { item in
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                        .font(.subheadline)
                }
                Spacer()
                
                Text(trendingMeal.price)
                    .font(.subheadline)
                    .bold()
            }
            .padding(.bottom, 30)
            .padding(.leading, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            .padding(.trailing, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)*/
            
        }
        .frame(width: 250, height: 250)
        .cornerRadius(10)
        
    }
    
    
}
