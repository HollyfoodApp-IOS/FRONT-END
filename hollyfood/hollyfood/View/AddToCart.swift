//
//  AddToCart.swift
//  hollyfood
//
//  Created by Khairi on 5/12/2022.
//

import SwiftUI

struct AddToCart: View {
    
    @EnvironmentObject var cartData: CartViewModel
    @Binding var selectedPlate: Plate
    
    var animation: Namespace.ID

    var body: some View{
        
        VStack{
            
            HStack(spacing: 15) {
                
                if !cartData.startAnimation {
                    
                    Image(selectedPlate.image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .matchedGeometryEffect(id: "image\(selectedPlate.id)", in: animation)
                }
                
                VStack(alignment: .trailing, spacing: 10, content: {
                    Text(selectedPlate.name)
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                        .multilineTextAlignment(.trailing)
                    
                    Text("Category: "+selectedPlate.category)
                        .fontWeight(.semibold)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.trailing)

                    Text("Price: \(selectedPlate.price)")
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                })
                .padding()
            }
            .padding()

            Button(action: {
                withAnimation(.easeInOut(duration: 0.7)){
                    cartData.startAnimation.toggle()
                }
                
                var orderline : Orderline = Orderline(id: selectedPlate.id, quantity: 1, price: selectedPlate.price, plateId: selectedPlate.id, orderId: "", plateName: selectedPlate.name, plateCategory: selectedPlate.category, plateImage: selectedPlate.image, offset: 0, isSwiped: false)
                
                cartData.cart.append(orderline)
                
                print(" ")
                print("CART == \(cartData.cart)")
                print("CART COUNT == \(cartData.cart.count)")
            })
            {
                Text("ADD TO CART")
                    .font(.system(size: 20))
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding(.vertical)
                    .frame(width: UIScreen.main.bounds.width - 70)
                    .background(
                        LinearGradient(gradient: .init(colors: [Color("PrimaryColor"), Color("PrimaryColor")]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    )
                
            }
            .cornerRadius(15)
            .padding(.horizontal, 25)

            

        }
        .background(Color.white.clipShape(CustomCorner(corners: [.topLeft, .topRight], radius: 35)))
        
    }

}

struct AddToCart_Previews: PreviewProvider {
    static var previews: some View {
        Menu()
    }
}
