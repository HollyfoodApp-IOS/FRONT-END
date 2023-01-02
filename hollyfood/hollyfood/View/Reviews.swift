//
//  Reviews.swift
//  hollyfood
//
//  Created by AlaBenRejab on 1/1/2023.
//

import SwiftUI

struct Review: View {
 
    let numberOfStars: Int
    
    var background: Color?
    @State var expand = false
    @State private var description: String = ""
    @State private var author: String = ""
    var item :RestaurantElement
    @ObservedObject var viewModel=CommentViewModel()

    @State var userID:String = UserViewModel.session?.id ?? ""
    
    var body: some View {
        VStack(spacing: 0){
            
            //reviewRestaurant.zIndex(25)
            VStack{
                Centerview(expand: self.$expand, resto: item).offset(y: -25).onTapGesture { endEditing(force: true) }

                
                Spacer()
                
                HStack{
                    Spacer()
                    HStack {
                        TextField("New Comment ...", text: $description)
                        
                        Button(action: {viewModel.AddComment(idRestaurant: item.id,description: description, author:userID)}) {
                            Text("Send")
                        }
                    }
                    .padding([.leading, .top, .trailing])
                    /* TextField(text:$description, prompt: Text("Required")) {
                     Text("Username")
                     }                    .padding()
                     .background(Color.white)
                     .cornerRadius(5)
                     Button(action: {viewModel.AddComment(idRestaurant: item.id,description: description, author:"ala")}, label: {
                     Text("See Comments")
                     .fontWeight(.bold)
                     .foregroundColor(.white)
                     .padding(.vertical, 10)
                     .padding(.horizontal, 100)
                     .background(Color.red)
                     .cornerRadius(10)
                     
                     })*/
                    Spacer()
                }
            }
                .animation(.easeInOut)
        }.keyboardManagment()
    }
    var reviewRestaurant :some View{
        VStack(alignment: .leading, spacing: 12) {
            restaurant
            Rating(numberOfStars: numberOfStars)
            review
        }.padding()
            .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
            .background(Color("Color1"))
            .clipShape(shape())
            .animation(.default)
        /*.padding(12)
        .background(background ?? .secondary)
        .clipShape(RoundedRectangle(cornerRadius: 14))
        .navigationTitle(name)*/
    }
    
    var restaurant: some View {
        HStack(spacing: 15) {
            Image(item.photo)
            //userTextContent
        }.padding(.top)
    }
    
   
    
    var review: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(item.name)
                .font(Font.subheadline.bold())
                .foregroundColor(.flatDarkBackground)
            
            Text(item.description)
                .font(Font.footnote.weight(.regular))
                .foregroundColor(.secondary)
        }
    }
}

/*var userTextContent: some View {
    VStack(alignment: .leading, spacing: 2) {
        HStack(alignment: .top, spacing: 15) {
            Text(name)
                .font(Font.subheadline.bold())
            Spacer()
            
            HStack(spacing: 6) {
                Text(date)
                    .font(Font.caption.weight(.regular))
                    .foregroundColor(.secondary)
                
               // NavigationLinkIcon()
            }
        }
        
        Text(whenCompleted)
            .font(Font.caption.weight(.regular))
            .foregroundColor(.secondary)
    }
}
 */
private func endEditing(force: Bool) {
    UIApplication.shared.windows
        .forEach { $0.endEditing(force) }
}

