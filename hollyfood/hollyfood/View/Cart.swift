//
//  Cart.swift
//  hollyfood
//
//  Created by Khairi on 3/12/2022.
//

import SwiftUI

struct Cart: View {
    
    @EnvironmentObject var viewModel: CartViewModel
    
    @Binding var restaurant: String
    @Binding var restaurantName: String

    @ObservedObject var orderViewModel = OrderViewModel()
    @ObservedObject var orderlineViewModel = OrderlineViewModel()
    @ObservedObject var userViewModel = UserViewModel()

    @State var userID: String = UserViewModel.session?.id ?? ""
    @State var orderID:String = ""

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
                        .foregroundColor(Color("GrayColor"))

                    Spacer()
                    Text(calculateTotalPrice())
                        .font(.title)
                        .fontWeight(.heavy)
                        .foregroundColor(Color("DarkColor"))
                }
                .padding([.top, .horizontal])

                Button(action: {
                    
                    var price: Float = 0
                    viewModel.cart.forEach { orderline in
                        price += Float(orderline.quantity) * orderline.price
                    }
                    
                    orderViewModel.addOrder(order: Order(id: "", price: price, user: userID, restaurant: restaurant, createdAt: ""), onSuccess: {(orderId) in
                        orderID = orderId
                        
                        print("CART COUNT == \(viewModel.cart.count)")
                        print("CART == \(viewModel.cart)")
                        print("ORDER ID == \(orderID)")
                        print(" ")
                        
                    viewModel.cart.forEach { orderline in
                        //print(orderline)
                        orderlineViewModel.addOrderline(orderline: Orderline(id: "", quantity: orderline.quantity, price: orderline.price, plate: orderline.plate, order: orderID, plateName: orderline.plateName, plateCategory: orderline.plateCategory, plateImage: orderline.plateImage, offset: orderline.offset, isSwiped: orderline.isSwiped))
                    }
                        
                    viewModel.cart.removeAll()

                    })
                    
                }, label: {
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
            .background(Color("LightColor"))
        }
        .background(Color("LightColor").ignoresSafeArea())
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
        Tab()
    }
}
