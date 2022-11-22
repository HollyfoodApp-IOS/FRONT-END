//
//  Tab.swift
//  hollyfood
//
//  Created by Khairi on 18/11/2022.
//

import SwiftUI

struct Tab: View {
    var body: some View {
        Main()
    }
}

struct Tab_Previews: PreviewProvider {
    static var previews: some View {
        Tab()
    }
}

struct Main: View{
    
    @State var selectedTab = ""
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    @State var xAxis: CGFloat = 0
    
    @Namespace var animation

    var body: some View{
        
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
            TabView(selection: $selectedTab){
                Profile()
                    .ignoresSafeArea(.all, edges: .all)
                    .tag("person.fill")
                Restaurants()
                    .ignoresSafeArea(.all, edges: .all)
                    .tag("fork.knife")
                MyRestaurants()
                    .ignoresSafeArea(.all, edges: .all)
                    .tag("homekit")
            }
            
            HStack(spacing: 0){
                ForEach(tabs,id: \.self){ image in
                    GeometryReader {reader in
                        Button(action: {
                            withAnimation(.spring()){
                                selectedTab = image
                                xAxis = reader.frame(in: .global).minX
                            }
                        }, label: {
                         
                            Image(systemName: image)
                                .resizable()
                                .renderingMode(.template)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25, height:25)
                                .foregroundColor(selectedTab == image ? getColor(image: image) : Color.white)
                                .padding(selectedTab == image ? 15 : 0)
                                .background(Color("Color 1").opacity(selectedTab == image ? 1 : 0).clipShape(Circle()))
                                .matchedGeometryEffect(id: image, in: animation)
                                .offset(x: selectedTab == image ? (reader.frame(in: .global).minX - reader.frame(in: .global).midX) : 0, y: selectedTab == image ? -50 : 0)
                        })
                        .onAppear(perform: {
                            if image == tabs.first{
                                xAxis = reader.frame(in: .global).minX
                            }
                        })
                    }
                    
                    .frame(width: 25, height:25)
                    if image != tabs.last{Spacer(minLength: 0)}
                    
                }
            }
            .padding(.horizontal, 30)
            .padding(.vertical)
            .background(Color("Color 1").clipShape(CustomShape(xAxis: xAxis)).cornerRadius(12))
            .padding(.horizontal)
            // bottom edge
            .padding(.bottom,UIApplication.shared.windows.first?.safeAreaInsets.bottom)
        }
        .ignoresSafeArea(.all, edges: .bottom)
    }
    
    func getColor(image: String)->Color{
        
        switch image {
        case "person.fill":
            return Color.white
        case "fork.knife":
            return Color.white
        case "homekit":
            return Color.white
        default:
            return Color.blue
            
        }
    }
}

var tabs = ["homekit", "fork.knife", "person.fill"]

struct CustomShape: Shape{
    
    var xAxis: CGFloat
    
    var animatableData: CGFloat{
        get{return xAxis}
        set{xAxis = newValue}
    }
    
    func path(in rect: CGRect) -> Path {
        
        return Path{path in
            
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            
            let center = xAxis
            
            path.move(to: CGPoint(x: center - 50, y: 0))
            
            let to1 = CGPoint(x: center, y: 35)
            let control1 = CGPoint(x: center - 25, y: 0)
            let control2 = CGPoint(x: center - 25, y: 35)
            
            let to2 = CGPoint(x: center + 50, y: 0)
            let control3 = CGPoint(x: center + 25, y: 35)
            let control4 = CGPoint(x: center + 25, y: 0)
            
            path.addCurve(to: to1, control1: control1, control2: control2)
            path.addCurve(to: to2, control1: control3, control2: control4)

        }
    }
}
