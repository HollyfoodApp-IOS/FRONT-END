//
//  PlateDetail.swift
//  hollyfood
//
//  Created by Khairi on 3/12/2022.
//

import SwiftUI

struct PlateDetail: View {
    
    @Binding var selectedPlate: Plate
    @Binding var show: Bool

    var animation: Namespace.ID
    
    @State var loadContent = false

    var body: some View {
        
        ScrollView(UIScreen.main.bounds.height < 750 ? .vertical : .init(), content: {
            
            VStack{
                
                HStack(spacing: 25) {

                    Button(action: {
                        // Close view
                        withAnimation(.spring()) {
                            show.toggle()
                        }
                    }, label: {
                        /*Image(systemName: "chevron.left")
                            .font(.title)
                            .foregroundColor(.black)*/
                        Text("Cancel")
                            .font(.title)
                            .foregroundColor(.black)


                    })
                    Spacer()

                }
                .padding()
                
                VStack{
                    
                    Image(selectedPlate.image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .matchedGeometryEffect(id: "image\(selectedPlate.id)", in: animation)
                        .frame(width: 200)
                        .padding()
                    
                    Text(selectedPlate.name)
                        .font(.title)
                        .fontWeight(.heavy)
                        .foregroundColor(.black)
                    
                    Text("Category: "+selectedPlate.category)
                        .foregroundColor(.gray)
                        .padding()

                    
                }
                .frame(width: 364)
                .background(
                    Color("PrimaryColor")
                        .opacity(0.1)
                        .clipShape(PlateDetailShape())
                        .matchedGeometryEffect(id: "color\(selectedPlate.id)", in: animation)

                )
                .cornerRadius(15)
                .padding()

                VStack{
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Price")
                            .fontWeight(.heavy)
                            .foregroundColor(.white)

                        Text("\(selectedPlate.price)")
                            .foregroundColor(.white)
                    }
                    .padding()
                    .frame(width: UIScreen.main.bounds.width - 30, alignment: .leading)
                    .background(Color("SecondaryColor"))
                    .cornerRadius(15)
                                    
                    Button(action: {}, label: {
                       Text("ADD TO CART")
                           .fontWeight(.bold)
                           .foregroundColor(.white)
                           .padding(.vertical)
                           .frame(width: UIScreen.main.bounds.width - 100)
                           .background(Color("AddCartBtnColor"))
                           .cornerRadius(15)
                   })
                   .padding(.vertical)


                }
                .padding([.horizontal, .bottom])
                .frame(height: loadContent ? nil : 0)
                .opacity(loadContent ? 1 : 0)

                
                Spacer(minLength: 0)

            }

        })
        .onAppear(perform: {
            withAnimation(Animation.spring().delay(0.45)) {
                loadContent.toggle()
            }
        })


    }
}

struct PlateDetail_Previews: PreviewProvider {
    static var previews: some View {
        Menu()
    }
}

