//
//  CategoryButton.swift
//  hollyfood
//
//  Created by Khairi on 30/11/2022.
//

import SwiftUI

struct CategoryButton: View {
    
    @ObservedObject var viewModel = PlateViewModel()

    var title: String
    @Binding var selected: String
    @Binding var plates: [Plate]

    var animation: Namespace.ID

    var body: some View {
        Button(action: {
            withAnimation(.spring()) {
                selected = title
            }
            print(selected)
            

        }, label: {
                        
        Text(title)
            .font(.system(size: 15))
            .fontWeight(.bold)
            .foregroundColor(selected == title ? .white : .black)
            .padding(.vertical, 10)
            .padding(.horizontal, selected == title ? 20 : 0)
            .background(
                ZStack {
                    if selected == title {
                        Color("PrimaryColor")
                            .clipShape(Capsule())
                            .matchedGeometryEffect(id: "Tab", in: animation)
                    }
                }
            )
        })
    }
}

struct CategoryButton_Previews: PreviewProvider {
    static var previews: some View {
        
        ContentView()
    }
}
