//
//  CommentView.swift
//  hollyfood
//
//  Created by AlaBenRejab on 1/1/2023.
//

import SwiftUI

struct CommentView: View {
    
    var data : Comment
    //var image:String
    var body: some View {
        VStack{
            HStack(spacing:12){
                
                
                Image("User")
                    .resizable()
                    .frame(width : 55, height: 50,alignment: .center)
                    .aspectRatio( contentMode: .fill)
                    .cornerRadius(25)
                VStack(alignment: .leading, spacing:12){
                    HStack{
                        Text(data.author)
                            .foregroundColor(.blue)
                            .font(.system(size: 18,weight: .semibold,design: .default))
                        Spacer()
                    }
                    HStack{
                        Text(data.date)
                            .foregroundColor(.secondary)
                        Spacer()
                    }
                }
                Spacer()
            }
            Spacer()
            HStack{
                Text(data.CommentText)
                    .font(.system(size:24,weight: .regular,design:.default))
                    .multilineTextAlignment(.leading)
                Spacer()
            }
        }
    }
}
struct Centerview : View{
    
    @Binding var expand : Bool
    @ObservedObject var viewModel=CommentViewModel()
    @ObservedObject var restaurantViewModel = RestaurantModelView()
    var resto :RestaurantElement
    var body : some View{
        
        Spacer()
        VStack{
            
            
            List{
                
                ForEach(viewModel.commentaires, id: \.id)  {commentaire in
                    
                    
                    CommentView(data: commentaire)
                }
                
            }.onAppear(perform:{viewModel.getAllComments(id: resto.id)})
                .refreshable {
                }
        }.padding(.top, 20)
            .background(Color.white)
            .clipShape(shape())
        
    }
}
struct shape : Shape {
    
    func path(in rect: CGRect) -> Path {
        
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.bottomLeft,.bottomRight], cornerRadii: CGSize(width: 30, height: 30))
        
        return Path(path.cgPath)
    }
}
    
