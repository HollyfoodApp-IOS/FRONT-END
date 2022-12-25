//
//  OrderDetail.swift
//  hollyfood
//
//  Created by Khairi on 11/12/2022.
//

import SwiftUI

struct OrderDetail: View {
    
    @Binding var selectedOrder: Order
    @Binding var show: Bool

    var animation: Namespace.ID
    
    @State var loadContent = false
    
    @ObservedObject var userViewModel = UserViewModel()
    @ObservedObject var orderlineViewModel = OrderlineViewModel()
    @ObservedObject var plateViewModel = PlateViewModel()

    @State var fullname : String = ""
    @State var phone : String = ""
    
    @ObservedObject var translation = Translation()
    @State var Cancel : String = ""
    @State var Client : String = ""
    @State var Phone_Number : String = ""
    @State var Order_Date : String = ""
    @State var Plate_Name : String = ""
    @State var Category : String = ""
    @State var Price : String = ""
    @State var Quantity : String = ""
    @State var DT : String = ""
    @State var Total_Price : String = ""


    var body: some View {
        
        ScrollView(UIScreen.main.bounds.height < 750 ? .vertical : .init(), content: {
            
            VStack{
                
                HStack(spacing: 25) {

                    Button(action: {
                        withAnimation(.spring()) {
                            show.toggle()
                        }
                    }, label: {
                        /*Image(systemName: "chevron.left")
                            .font(.title)
                            .foregroundColor(.black)*/
                        Text(Cancel)
                            .font(.title)
                            .foregroundColor(Color("DarkColor"))


                    })
                    Spacer()

                }
                .padding()
                
                VStack{
                    
                    Image("logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .matchedGeometryEffect(id: "image\(selectedOrder.id)", in: animation)
                        .frame(width: 200)
                        .padding()
                    
                    Text(Client+": "+fullname)
                        .font(.title)
                        .fontWeight(.heavy)
                        .foregroundColor(.black)
                    
                    Text(Phone_Number+": "+phone)
                        .foregroundColor(.gray)
                        .padding(.top, 10)

                    Text(Order_Date+": "+selectedOrder.createdAt.prefix(10))
                        .foregroundColor(.gray)
                        .padding(.top, 3)
                        .padding(.bottom,10)

                    
                }
                .frame(width: 364)
                .background(
                    Color("PrimaryColor")
                        .opacity(0.1)
                        .clipShape(PlateDetailShape())
                        .matchedGeometryEffect(id: "color\(selectedOrder.id)", in: animation)

                )
                .cornerRadius(15)
                .padding()
                    
                VStack{
                    
                    VStack(alignment: .leading, spacing: 8) {
                        
                        Text("Order")
                            .fontWeight(.heavy)
                            .foregroundColor(.white)

                        ForEach(orderlineViewModel.orderlines) { orderline in
                            
                            Text(
                                "* \(Plate_Name): \(orderline.plateName), \(Category):  \(orderline.plateCategory), \(Quantity): \(orderline.quantity), \(Price): "+String(format: "%.2f \(DT)", orderline.price)+"."
                            )
                                .foregroundColor(.white)
                        }

                    }
                    .padding()
                    .frame(width: UIScreen.main.bounds.width - 30, alignment: .leading)
                    .background(Color("SecondaryColor"))
                    .cornerRadius(15)
                    
                    Text(String(format: "\(Total_Price): %.2f \(DT)", selectedOrder.price))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 100)
                        .background(Color("AddCartBtnColor"))
                        .cornerRadius(15)
                        .padding(.vertical)


                }
                .padding([.horizontal, .bottom])
                .frame(height: loadContent ? nil : 0)
                .opacity(loadContent ? 1 : 0)

                

                
                Spacer(minLength: 0)

            }

        })
        .onAppear(perform: {
            
            userViewModel.getUser(id: selectedOrder.user) { us in
                fullname = us.fullname
                phone = us.phone
            }
            
            orderlineViewModel.getOrderlinesByOrder(order: selectedOrder.id)
            
            withAnimation(Animation.spring().delay(0.45)) {
                loadContent.toggle()
            }
            
            translation.Translate()
            Cancel = translation.Cancel
            Client = translation.Client
            Phone_Number = translation.Phone_Number
            Order_Date = translation.Order_Date
            Plate_Name = translation.Plate_Name
            Category = translation.Category
            Price = translation.Price
            Quantity = translation.Quantity
            DT = translation.DT
            Total_Price = translation.Total_Price

        })
    }
}

struct OrderDetail_Previews: PreviewProvider {
    static var previews: some View {
        Tab()
    }
}
