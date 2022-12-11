//
//  TabBar.swift
//  hollyfood
//
//  Created by Khairi on 26/11/2022.
//

import SwiftUI

struct TabBar: View {
    var body: some View {
        NavigationView()
        {
            CustomTabView()
                    .navigationTitle("")
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationBarHidden(true)
        }
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}

struct CustomTabView : View {
    
    @State var selectedTab = "gearshape.fill"
    
    var body: some View {
        
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
            TabView(selection: $selectedTab){
                MyRestaurants()
                    .tag("homekit")
                Restaurants()
                    .tag("fork.knife")
                Profile()
                    .tag("gearshape.fill")
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .ignoresSafeArea(.all, edges: .bottom)

            HStack(spacing: 0){
                ForEach(tab,id: \.self){ image in
                    TabButton(image: image, selectedTab: $selectedTab)
                    if image != tab.last{
                        Spacer(minLength: 0)
                    }
                }
            }
            .padding(.horizontal, 25)
            .padding(.vertical, 5)
            .background(Color("PrimaryColor"))
            .clipShape(Capsule())
            .shadow(color: Color.black.opacity(0.15), radius: 5, x: 5, y: 5)
            .shadow(color: Color.black.opacity(0.15), radius: 5, x: -5, y: -5)
            .padding(.horizontal)
            .padding(.bottom, 20)


        }
        .ignoresSafeArea(.all, edges: .bottom)
    }
}

var tab = ["homekit", "fork.knife", "gearshape.fill"]

struct TabButton : View {
    
    var image : String
    @Binding var selectedTab : String
    
    var body: some View {
        Button(action: {selectedTab = image}){
            
            Image(systemName: image)
                .renderingMode(.template)
                .foregroundColor(selectedTab == image ? Color(.white) : Color.black.opacity(0.4))
                .padding()

        }
    }
}
