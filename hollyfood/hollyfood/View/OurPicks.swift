//
//  OurPicks.swift
//  hollyfood
//
//  Created by AlaBenRejab on 1/1/2023.
//

import SwiftUI

struct OurPicks: View {
     var card : RestaurantElement
    @State var expand = false
    @Binding var hero : Bool
    @State var heart = "heart.fill"
    @State var dscrip="The best of the best"
    var body: some View {
        VStack {
            ZStack {
                Image(card.photo)
                    .resizable()
                    .frame(width: self.expand ? (UIScreen.main.bounds.width) : (UIScreen.main.bounds.width)*0.9 , height: self.expand ? (UIScreen.main.bounds.height)*0.3 : (UIScreen.main.bounds.height)*0.25 )
                    .cornerRadius(self.expand ? 5 : 20)
                    .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                if (self.expand) {
                    HStack{
                        Spacer()
                        Button(action: {
                            
                            withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.8, blendDuration: 0)){
                                
                                self.expand.toggle()
                                self.hero.toggle()
                            }
                            
                        }) {
                            
                            Image(systemName: "xmark")
                                .foregroundColor(Color("LightColor"))
                                .padding()
                                .background(Color("DarkColor").opacity(0.8))
                                .clipShape(Circle())
                            
                        }
                    }
                    .padding(.all, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                }
            }.edgesIgnoringSafeArea(.top)
            
            
            
            HStack {
                Text(card.name)
                    .bold()
                    .foregroundColor(Color("DarkColor"))
                    .padding(.all, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                
                HStack {
                    ForEach(0 ..< 5) { item in
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                            .font(.subheadline)
                    }
                   Spacer()
               }

            }
            .padding(.leading, self.expand ? 10 : 20)
            
            /*
             HStack {
                Text(dscrip)
                    .font(.subheadline)
                    .foregroundColor(Color("GrayColor"))
                    .padding(.leading, self.expand ? 20 : 30)
                Spacer()
            }
             */
            
            /*
             HStack {
                ForEach(0 ..< 5) { item in
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                        .font(.subheadline)
                }
            }
            .padding(.bottom, 30)
            .padding(.leading, 0)
            .padding(.trailing, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            .padding(.leading, self.expand ? 10 : 20)
            .padding(.trailing, self.expand ? 10 : 20)
             */
            
            if self.expand {
                VStack{
                    HStack {
                        Text("Description")
                            .font(.title)
                            .bold()
                            .padding(.all, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                        
                        Spacer()
                        
                        Button(action: {
                            withAnimation(.spring(dampingFraction: 0.5)) {
                                heart = "heart"
                            }
                        }, label: {
                            Image(systemName: heart)
                                .font(.title)
                                .foregroundColor(.red)
                            
                        })
                        .padding(.trailing, 30)
                    }
                    Text(card.description)
                        .padding(.all, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                }
                
            }
            

        }
    }
    
    struct OurPicks_Previews: PreviewProvider {
        static var previews: some View {
            Tab()
        }
    }

 
}

