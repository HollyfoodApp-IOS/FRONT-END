//
//  OrderRowView.swift
//  hollyfood
//
//  Created by Khairi on 9/12/2022.
//

import SwiftUI

struct OrderRowView: View {
    
    @Binding var order: Order
    @Binding var ordersList: [Order]
    
    var date : String = ""
    
    @ObservedObject var orderViewModel = OrderViewModel()
    
    @ObservedObject var translation = Translation()
    @State var Order_Date : String = ""
    @State var Order_Price : String = ""
    @State var DT : String = ""

    var animation: Namespace.ID

    var body: some View {
        
        HStack(spacing: 15) {
            
            Image("logo")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 60, height: 60)
                .matchedGeometryEffect(id: "image\(order.id)", in: animation)

            VStack(alignment: .leading, spacing: 8, content: {
                Text(Order_Date+": "+order.createdAt.prefix(10))
                    .fontWeight(.bold)
                

                Text(String(format: "\(Order_Price): %.2f \(DT)", order.price))
                    .font(.caption)
                    .foregroundColor(.gray)
            })
            .frame(maxWidth: .infinity, alignment: .leading)

            Button(action: {
                
                withAnimation(.spring()) {
                    deleteOrderRow()
                }

            }, label: {
                Image(systemName: "trash.fill")
                    .foregroundColor(Color("PrimaryColor"))
                    .padding()
                    .background(Color("PrimaryColor").opacity(0.2))
                    .clipShape(Circle())
            })
        }
        .background(
            Color("LightColor")
                .opacity(0.1)
                .ignoresSafeArea()
                .matchedGeometryEffect(id: "color\(order.id)", in: animation)
        )
        .padding(.horizontal)
        .onAppear(perform: {
            translation.Translate()
            Order_Date = translation.Order_Date
            Order_Price = translation.Order_Price
            DT = translation.DT
        })

    }
    
    func deleteOrderRow() {
        orderViewModel.deleteOrder(id: order.id, onSuccess:{
            ordersList.removeAll { order.id == $0.id }
        })
    }
}

struct OrderRowView_Previews: PreviewProvider {
    static var previews: some View {
        Tab()
    }
}

