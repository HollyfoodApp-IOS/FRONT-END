//
//  CartItem.swift
//  hollyfood
//
//  Created by Khairi on 5/12/2022.
//

import SwiftUI

struct CartItem: View {
    
    @Binding var orderline: Orderline
    @Binding var cart: [Orderline]

    var body: some View {
        
        ZStack{
            LinearGradient(gradient: .init(colors: [Color("PrimaryColor"), Color("PrimaryColor")]), startPoint: .leading, endPoint: .trailing)

            HStack {
                Spacer()

                Button(action: {
                    withAnimation(.easeIn) {
                        deleteOrderline()
                    }
                }, label: {
                    Image(systemName: "trash")
                        .font(.title)
                        .foregroundColor(.white)
                        .frame(width: 90, height: 50)
                })
            }

            HStack(spacing: 15) {
                
                Image(orderline.plateImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 130, height: 130)
                    .cornerRadius(15)
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
                    .shadow(color: Color.black.opacity(0.08), radius: 5, x: 0, y: -5)

                VStack(alignment: .leading, spacing: 10, content: {
                    Text(orderline.plateName)
                        .fontWeight(.semibold)
                        .foregroundColor(.black)

                    Text("Category: "+orderline.plateCategory)
                        .fontWeight(.semibold)
                        .foregroundColor(.gray)

                    HStack(spacing: 15) {
                        Text("Price: \(getPrice(value:orderline.price))")
                            .font(.title2)
                            .fontWeight(.heavy)
                            .foregroundColor(.black)

                        Spacer(minLength: 0)

                        Button(action: {
                            if orderline.quantity > 1 {
                                orderline.quantity -= 1
                            }
                        }, label: {
                            Image(systemName: "minus")
                                .font(.system(size: 16, weight: .heavy))
                                .foregroundColor(.black)
                        })

                        Text("\(orderline.quantity)")
                            .fontWeight(.heavy)
                            .foregroundColor(.black)
                            .padding(.vertical, 5)
                            .padding(.horizontal, 10)
                            .background(Color.black.opacity(0.06))

                        Button(action: {
                            orderline.quantity += 1
                        }, label: {
                            Image(systemName: "plus")
                                .font(.system(size: 16, weight: .heavy))
                                .foregroundColor(.black)
                        })
                    }
                })
            }
            .padding()
            .background(Color.white)
            .contentShape(Rectangle())
            .offset(x: orderline.offset)
            .gesture(
                DragGesture()
                    .onChanged(onChanged(value:))
                    .onEnded(onEnd(value:))
            )

        }
    }
    
    func onChanged(value: DragGesture.Value) {
        if value.translation.width < 0 {
            orderline.offset = value.translation.width - 90
        } else {
            orderline.offset = value.translation.width
        }
    }

    func onEnd(value: DragGesture.Value) {
        withAnimation(.easeOut) {
            if value.translation.width < 0 {
                if -value.translation.width > UIScreen.main.bounds.width / 2 {
                    orderline.offset = -1000
                    deleteOrderline()
                } else if -orderline.offset > 50 {
                    orderline.isSwiped = true
                    orderline.offset = -90
                } else {
                    orderline.isSwiped = false
                    orderline.offset = 0
                }
            } else {
                orderline.isSwiped = false
                orderline.offset = 0
            }
        }
    }

    func deleteOrderline() {
        cart.removeAll { orderline.id == $0.id }
    }

}

struct CartItem_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

func getPrice(value: Float) -> String {
    let format = NumberFormatter()
    format.numberStyle = .currency
    return format.string(from: NSNumber(value: value)) ?? ""
}















/*
 import SwiftUI

 struct ItemView: View {
     @Binding var item: Item
     @Binding var items: [Item]
     var body: some View {
         ZStack {
             LinearGradient(gradient: .init(colors: [Color("lightblue"), Color("blue")]), startPoint: .leading, endPoint: .trailing)

             // Delete button
             HStack {
                 Spacer()

                 Button(action: {
                     withAnimation(.easeIn) {
                         deleteItem()
                     }
                 }, label: {
                     Image(systemName: "trash")
                         .font(.title)
                         .foregroundColor(.white)
                         .frame(width: 90, height: 50)
                 })
             }

             HStack(spacing: 15) {
                 Image(item.image)
                     .resizable()
                     .aspectRatio(contentMode: .fill)
                     .frame(width: 130, height: 130)
                     .cornerRadius(15)

                 VStack(alignment: .leading, spacing: 10, content: {
                     Text(item.name)
                         .fontWeight(.semibold)
                         .foregroundColor(.black)

                     Text(item.details)
                         .fontWeight(.semibold)
                         .foregroundColor(.gray)

                     HStack(spacing: 15) {
                         Text("\(getPrice(value: item.price))")
                             .font(.title2)
                             .fontWeight(.heavy)
                             .foregroundColor(.black)

                         Spacer(minLength: 0)

                         Button(action: {
                             if item.quantity > 1 {
                                 item.quantity -= 1
                             }
                         }, label: {
                             Image(systemName: "minus")
                                 .font(.system(size: 16, weight: .heavy))
                                 .foregroundColor(.black)
                         })

                         Text("\(item.quantity)")
                             .fontWeight(.heavy)
                             .foregroundColor(.black)
                             .padding(.vertical, 5)
                             .padding(.horizontal, 10)
                             .background(Color.black.opacity(0.06))

                         Button(action: {
                             item.quantity += 1
                         }, label: {
                             Image(systemName: "plus")
                                 .font(.system(size: 16, weight: .heavy))
                                 .foregroundColor(.black)
                         })
                     }
                 })
             }
             .padding()
             .background(Color("gray"))
             .contentShape(Rectangle())
             .offset(x: item.offset)
             .gesture(
                 DragGesture()
                     .onChanged(onChanged(value:))
                     .onEnded(onEnd(value:))
             )
         }
     }

     func onChanged(value: DragGesture.Value) {
         if value.translation.width < 0 {
             item.offset = value.translation.width - 90
         } else {
             item.offset = value.translation.width
         }
     }

     func onEnd(value: DragGesture.Value) {
         withAnimation(.easeOut) {
             if value.translation.width < 0 {
                 if -value.translation.width > UIScreen.main.bounds.width / 2 {
                     item.offset = -1000
                     deleteItem()
                 } else if -item.offset > 50 {
                     item.isSwiped = true
                     item.offset = -90
                 } else {
                     item.isSwiped = false
                     item.offset = 0
                 }
             } else {
                 item.isSwiped = false
                 item.offset = 0
             }
         }
     }

     func deleteItem() {
         items.removeAll { item.id == $0.id }
     }
 }

 struct ItemView_Previews: PreviewProvider {
     static var previews: some View {
         ContentView()
     }
 }

 func getPrice(value: Float) -> String {
     let format = NumberFormatter()
     format.numberStyle = .currency
     return format.string(from: NSNumber(value: value)) ?? ""

 }
 */
