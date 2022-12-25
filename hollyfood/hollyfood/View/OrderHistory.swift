//
//  OrderHistory.swift
//  hollyfood
//
//  Created by Khairi on 9/12/2022.
//

import SwiftUI

struct OrderHistory: View {
    
    @Binding var type: String
    @Binding var id : String
    
    @State var searchQuery = ""
    @State var show = false
    
    @State var selectedOrder : Order = initialOrder[0]
    @Namespace var animation
    
    @ObservedObject var orderViewModel = OrderViewModel()
    
    @ObservedObject var translation = Translation()
    @State var Order : String = ""
    @State var History : String = ""
    @State var Search : String = ""
    @State var ORDERS : String = ""
    @State var Order_History : String = ""

    var body: some View {
                
        ZStack(alignment: .bottom){

            VStack{
                
                HStack{
                    (
                        Text(Order)
                            .fontWeight(.bold)
                            .foregroundColor(Color("DarkColor"))
                        +
                        Text(" "+History)
                            .foregroundColor(Color("GrayColor"))
                    )
                    .font(.largeTitle)
                    .padding()
                    
                    Spacer()
                }
                .padding()

                VStack{
                    
                    HStack(spacing: 15) {
                        Image(systemName: "magnifyingglass")
                            .font(.system(size: 23, weight: .bold))
                            .foregroundColor(Color("GrayColor"))

                        TextField(Search, text: $searchQuery)
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal)
                    .background(Color("DarkColor").opacity(0.05))
                    .cornerRadius(8)
                    .padding()

                        
                    HStack {
                        Text(ORDERS)
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundColor(.gray)

                        Rectangle()
                            .fill(Color.gray.opacity(0.6))
                            .frame(height: 0.5)
                    }
                    .padding()
                }
                
                ScrollView(.vertical, showsIndicators: false, content: {
                    
                    VStack(spacing: 15){
                    
                        ForEach(searchQuery == "" ? orderViewModel.orders : orderViewModel.orders.filter{$0.createdAt.lowercased().contains(searchQuery.lowercased())})
                        {
                            order in
                            OrderRowView(order: $orderViewModel.orders[getIndex(order: order)], ordersList: $orderViewModel.orders, animation: animation)
                                .onTapGesture {
                                    withAnimation(.spring()) {
                                        selectedOrder = order
                                        show.toggle()
                                    }
                                }

                        }

                    }
                    .onAppear(perform: {
                        
                        orderViewModel.getOrders(type: type, id: id)
                        print(" ")
                        print("====Orders Table====")
                        print(orderViewModel.orders)

                    })
                                        
                })
            }
            .opacity(show ? 0 : 1)

            if show {
                OrderDetail(selectedOrder: $selectedOrder, show: $show, animation: animation)
            }


        }
        .navigationTitle(Order_History)
        .navigationBarTitleDisplayMode(.inline)
        //.background(Color.white.ignoresSafeArea())
        .onAppear(perform: {
            translation.Translate()
            Order = translation.Order
            History = translation.History
            Search = translation.Search
            ORDERS = translation.ORDERS
            Order_History = translation.Order_History

        })

    }
    
    func getIndex(order: Order) -> Int {
        
        return orderViewModel.orders.firstIndex { (order1) -> Bool in
            
            return order.id == order1.id
            
        } ?? 0
    }

    
}

struct OrderHistory_Previews: PreviewProvider {
    static var previews: some View {
        Tab()
    }
}

var staticOrders = [
    Order(id: "1", price: 20.5, user: "khairi", restaurant: "Comme Chez Toi", createdAt: "2023-01-01"),
    Order(id: "2", price: 24, user: "khairi", restaurant: "Chanabou", createdAt: "2023-01-01")
]

var initialOrder = [
    Order(id: "", price: 0, user: "", restaurant: "", createdAt: "")
]
