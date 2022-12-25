//
//  AddToCart.swift
//  hollyfood
//
//  Created by Khairi on 5/12/2022.
//

import SwiftUI

struct AddToCart: View {
    
    @EnvironmentObject var cartData: CartViewModel
    @EnvironmentObject var plateViewModel: PlateViewModel

    @Binding var selectedPlate: Plate
    @Binding var restaurantID: String

    @State var existedPlate : Bool = false
    @State var existedPlateIndex : Int = 0

    var animation: Namespace.ID
    
    @ObservedObject var translation = Translation()
    @State var Category : String = ""
    @State var Price : String = ""
    @State var Add_To_Cart : String = ""
    @State var Edit_Plate : String = ""
    @State var Delete_Plate : String = ""
    @State var DT : String = ""

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
                        .foregroundColor(Color("DarkColor"))
                        .multilineTextAlignment(.trailing)
                    
                    Text(selectedPlate.category)
                        .fontWeight(.semibold)
                        .foregroundColor(Color("GrayColor"))
                        .multilineTextAlignment(.trailing)

                    Text(String(format: "\(Price): %.2f \(DT)", selectedPlate.price))
                        .fontWeight(.bold)
                        .foregroundColor(Color("DarkColor"))
                })
                .padding()
            }
            .padding()

            Button(action: {
                withAnimation(.easeInOut(duration: 0.7)){
                    cartData.startAnimation.toggle()
                }
                
                cartData.cart.forEach { orderline in
                    
                    if orderline.id == selectedPlate.id
                    {
                        existedPlate = true
                        existedPlateIndex = cartData.cart.firstIndex(of: orderline)!
                    }
                            
                }

                if !existedPlate
                {
                    var orderline : Orderline = Orderline(id: selectedPlate.id, quantity: 1, price: selectedPlate.price, plate: selectedPlate.id, order: "", plateName: selectedPlate.name, plateCategory: selectedPlate.category, plateImage: selectedPlate.image, offset: 0, isSwiped: false)
                    
                    cartData.cart.append(orderline)

                }
                else
                {
                    cartData.cart[existedPlateIndex].quantity += 1
                }
                
                
                print(" ")
                print("CART == \(cartData.cart)")
                print("CART COUNT == \(cartData.cart.count)")
            })
            {
                Text(Add_To_Cart)
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
            .padding(.bottom, 25)
            
            NavigationLink(destination: EditPlate(restaurantID: $restaurantID, selectedPlate: $selectedPlate).environmentObject(plateViewModel).navigationBarBackButtonHidden(false)) {
                Image(systemName: "square.and.pencil")
                    .foregroundColor(.yellow)

                Text(Edit_Plate)
                    .foregroundColor(.yellow)

            }.padding(.top, 1)
            
            Button(action: {
                
                deletePlate()

            }, label: {
                Image(systemName: "delete.forward")
                    .foregroundColor(.red)

                Text(Delete_Plate)
                    .foregroundColor(.red)
            }).padding(.top, 1)



        }
        .background(Color("LightColor").clipShape(CustomCorner(corners: [.topLeft, .topRight], radius: 35)))
        .onAppear(perform: {
            
            translation.Translate()
            Category = translation.Category
            Price = translation.Price
            Add_To_Cart = translation.Add_To_Cart
            Edit_Plate = translation.Edit_Plate
            Delete_Plate = translation.Delete_Plate
            DT = translation.DT

        })

    }
    
    func deletePlate() {
        
        plateViewModel.deletePlate(id: selectedPlate.id, onSuccess:{
            
            plateViewModel.plates.removeAll { selectedPlate.id == $0.id }
            
            withAnimation(.easeInOut(duration: 0.7)){
                cartData.deleteAnimation = true
                cartData.startAnimation.toggle()
            }

        })
    }


}

struct AddToCart_Previews: PreviewProvider {
    static var previews: some View {
        Tab()
    }
}
