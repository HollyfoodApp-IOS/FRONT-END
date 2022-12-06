//
//  Cart.swift
//  hollyfood
//
//  Created by Khairi on 3/12/2022.
//

import SwiftUI

struct Cart: View {
    
    @EnvironmentObject var viewModel: CartViewModel

    var body: some View {
        
        VStack{
            
            ScrollView(.vertical, showsIndicators: false){
                
                LazyVStack(spacing: 0) {
                    
                    ForEach(viewModel.cart) { orderline in
                        
                        CartItem(orderline: $viewModel.cart[getIndex(orderline: orderline)], cart: $viewModel.cart)
                    }
                }
            }
            
            
            VStack {
                HStack {
                    Text("Total")
                        .fontWeight(.heavy)
                        .foregroundColor(.gray)

                    Spacer()
                    Text(calculateTotalPrice())
                        .font(.title)
                        .fontWeight(.heavy)
                        .foregroundColor(.black)
                }
                .padding([.top, .horizontal])

                Button(action: {}, label: {
                    Text("Order Now")
                        .font(.title2)
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 30)
                        .background(
                            Color("PrimaryColor")
                            /*LinearGradient(gradient: .init(colors: [Color("PrimaryColor"), Color("SecondaryColor")]), startPoint: .leading, endPoint: .trailing)*/
                        )
                        .cornerRadius(15)
                })
            }
            .background(Color.white)

        }
        .background(Color.white.ignoresSafeArea())
        .navigationTitle("Cart")
        .navigationBarTitleDisplayMode(.inline)

    }
    
    func getIndex(orderline: Orderline) -> Int {
        
        return viewModel.cart.firstIndex { (orderline1) -> Bool in
            
            return orderline.id == orderline1.id
            
        } ?? 0
    }
    
    func calculateTotalPrice() -> String {
        var price: Float = 0
        viewModel.cart.forEach { orderline in
            price += Float(orderline.quantity) * orderline.price
        }

        return getPrice(value: price)
    }


}

struct Cart_Previews: PreviewProvider {
    static var previews: some View {
        //Cart()
        ContentView()
    }
}

/*
 


*/
