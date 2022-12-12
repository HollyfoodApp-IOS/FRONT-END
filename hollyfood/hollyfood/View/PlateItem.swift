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

                Text(String(format: "%.2f DT", plate.price))
                    .fontWeight(.heavy)
                    .foregroundColor(.black)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 10)
                    .background(Color.white.opacity(0.5))
                    .cornerRadius(10)
            }

            Image(plate.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.top, 30)
                .padding(.bottom)
                .padding(.horizontal, 10)

            Text(plate.name)
                .fontWeight(.bold)
                .foregroundColor(.black)
                .padding()

        }
        .background(
            Color("PrimaryColor")
                .opacity(0.1)
                .ignoresSafeArea()
        )
        .cornerRadius(15)

    }
}

struct PlateItem_Previews: PreviewProvider {
    static var previews: some View {
        Tab()
    }
}
