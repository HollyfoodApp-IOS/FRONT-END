//
//  PlateItem.swift
//  hollyfood
//
//  Created by Khairi on 30/11/2022.
//

import SwiftUI

struct PlateItem: View {
    
    var plate: Plate
    var animation: Namespace.ID
    
    var body: some View {
        VStack {
            HStack {
                Spacer(minLength: 0)

                Text("\(plate.price) DT")
                    .fontWeight(.heavy)
                    .foregroundColor(.black)
                    //.matchedGeometryEffect(id: "price\(plate.price)", in: animation)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 10)
                    .background(Color.white.opacity(0.5))
                    .cornerRadius(10)
            }

            Image(plate.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                //.matchedGeometryEffect(id: "image\(plate.id)", in: animation)
                .padding(.top, 30)
                .padding(.bottom)
                .padding(.horizontal, 10)

            Text(plate.name)
                .fontWeight(.bold)
                .foregroundColor(.black)
                //.matchedGeometryEffect(id: "name\(plate.name)", in: animation)
                .padding()

        }
        .background(
            Color("PrimaryColor")
                .opacity(0.1)
                .ignoresSafeArea()
                //.matchedGeometryEffect(id: "color\(plate.id)", in: animation)
        )
        .cornerRadius(15)

    }
}

struct PlateItem_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
