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
    
    var animation: Namespace.ID

    var body: some View {
        
        HStack(spacing: 15) {
            
            Image("logo")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 60, height: 60)
                .matchedGeometryEffect(id: "image\(order.id)", in: animation)

            VStack(alignment: .leading, spacing: 8, content: {
                Text("Date: "+order.createdAt.prefix(10))
                    .fontWeight(.bold)
                
                Text("Price: "+String(format: "%.2f DT", order.price))
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
            Color(.white)
                .opacity(0.1)
                .ignoresSafeArea()
                .matchedGeometryEffect(id: "color\(order.id)", in: animation)
        )
        .padding(.horizontal)
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

