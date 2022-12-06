//
//  Menu.swift
//  hollyfood
//
//  Created by Khairi on 30/11/2022.
//

import SwiftUI

struct Menu: View {
    var body: some View {
        Menu_Code()
    }
}

struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        Menu()
    }
}

struct Menu_Code: View {
    
    @ObservedObject var viewModel = PlateViewModel()
    @StateObject var cartData = CartViewModel()

    @State var addPlate = false
    @State var cart = false
    @State var selected = categories[0]
    @Namespace var animation

    @State var show = false
    @State var selectedPlate : Plate = initialPlate[0]
        
    var body: some View {
        
        ZStack(alignment: .bottom){
            
            VStack{
                
                HStack{
                    
                    VStack(alignment: .leading, spacing: 5, content: {
                        Text("Restaurant Name")
                            .font(.title)
                            .foregroundColor(.black)
                        Text("Menu")
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                            .foregroundColor(.black)
                        
                    })
                    .padding(.horizontal)

                    
                    Spacer()
                    
                    NavigationLink(destination:
                        Cart()
                            .environmentObject(cartData)
                            .navigationBarBackButtonHidden(false),
                        isActive: $cart) {

                        Button(action: {
                            cart = true
                        }, label: {
                            Image(systemName: "bag.fill")
                                .font(.title3)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color("PrimaryColor"))
                                .clipShape(Circle())
                                .overlay(
                                    Text("\(cartData.cart.count)")
                                        .font(.caption)
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                        .padding(10)
                                        .background(Color.red)
                                        .clipShape(Circle())
                                        .offset(x: 15, y: -10)
                                        .opacity(cartData.cart.count != 0 ? 1 : 0)
                                )
                        })
                    }

                }
                .padding()
                /*HStack {
                    
                    
                    
                    Spacer(minLength: 0)
                }*/
                
                //Categories
                ScrollView(.horizontal) {
                    
                    HStack(spacing: 20) {
                        
                        ForEach(categories, id: \.self) { tab in
                            
                            Button(action: {
                                withAnimation(.spring()) {
                                    selected = tab
                                }
                                print(selected)
                                
                                if selected == "All"
                                {
                                    viewModel.getPlates()
                                }
                                else
                                {
                                    viewModel.getPlatesByCategory(category: selected)
                                }

                                print("=====AFTER REMOVE=====")
                                print(viewModel.plates)
                                print("======================")


                            }, label: {
                                            
                            Text(tab)
                                .font(.system(size: 15))
                                .fontWeight(.bold)
                                .foregroundColor(selected == tab ? .white : .black)
                                .padding(.vertical, 10)
                                .padding(.horizontal, selected == tab ? 20 : 0)
                                .background(
                                    ZStack {
                                        if selected == tab {
                                            Color("PrimaryColor")
                                                .clipShape(Capsule())
                                                .matchedGeometryEffect(id: "Tab", in: animation)
                                        }
                                    }
                                )
                            })

                            
                            /*CategoryButton(title: tab, selected: $selected, plates : $viewModel.plates, animation: animation)*/
                            
                            if tabs.last != tab {
                                Spacer(minLength: 0)
                            }
                        }
                    }
                    .padding()
                    .padding(.top, 5)

                }
                
                ScrollView {
                                    
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 20),count: 2 ), spacing: 25){


                            ForEach(viewModel.plates) { plate in

                                PlateItem(plate: plate, animation: animation)
                                    .onTapGesture {
                                        withAnimation(.spring()) {
                                            selectedPlate = plate
                                            cartData.showCart.toggle()
                                            //show.toggle()
                                        }
                                    }
                            }
                    }
                    .onAppear(perform:viewModel.getPlates)
                    .padding()
                    
                    NavigationLink(destination: AddPlate().navigationBarBackButtonHidden(false), isActive: $addPlate) {
                        
                        Button(action: {
                            addPlate = true
                        })
                        {
                            
                            Text("ADD PLATE")
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
                        .padding(.horizontal, 25)

                        
                    }.padding()

                }
                
            }
            .opacity(show ? 0 : 1)
            .blur(radius: cartData.showCart ? 50 : 0)
            
            AddToCart(selectedPlate: $selectedPlate, animation: animation)
                .environmentObject(cartData)
                .offset(y: cartData.showCart ? cartData.startAnimation ? 500 : 0 : 500)
            /*if show{
                PlateDetail(selectedPlate: $selectedPlate, show: $show, animation: animation)
            }*/
             
            if cartData.startAnimation {
                
                VStack{
                    Spacer()
                    
                    ZStack{
                        
                        Color.white
                            .frame(width: cartData.imageAnimation ? 100 : rect.width * 1.3,
                                   height: cartData.imageAnimation ? 100 : rect.width * 1.3
                            )
                            .clipShape(Circle())
                        
                        Image(selectedPlate.image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .matchedGeometryEffect(id: "image\(selectedPlate.id)", in: animation)
                            .frame(width: 80, height: 80)
                    }
                    .offset(y: cartData.saveCart ? 70 : -120)
                    .scaleEffect(cartData.saveCart ? 0.6 : 1)
                    .onAppear(perform: cartData.performAnimations)
                    
                    if !cartData.saveCart{
                        Spacer()
                    }
                    
                    Image(systemName: "bag\(cartData.addPlateToCart ? ".fill" : "")")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding()
                        .background(cartData.addPlateToCart ? Color.red :
                            Color("PrimaryColor"))
                        .clipShape(Circle())
                        .offset(y: cartData.showBag ? -50 : 300)
                }
                .frame(width: rect.width)
                .offset(y: cartData.endAnimation ? 500 : 0)
            }

        }
        .background(Color.white.ignoresSafeArea())
        .onChange(of: cartData.endAnimation, perform: { value in
            
            if cartData.endAnimation {
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [self] in
                    
                    withAnimation {
                        cartData.showCart.toggle()
                    }

                    cartData.startAnimation = false
                    cartData.endAnimation = false
                    cartData.addPlateToCart = false
                    cartData.showBag = false
                    cartData.imageAnimation = false
                    cartData.saveCart = false
                    cartData.count += 1

                }

            }
        })

    }

}

var categories = ["All", "Pizza", "Sandwich", "Pasta", "Plate"]

var initialPlate = [
    Plate(id: "0", name: "0", category: "0", price: 0, image: "0", restaurant: "0")
]

extension View {
    var rect: CGRect {
        UIScreen.main.bounds
    }
}


/*
 struct AddToCart: View {
     @EnvironmentObject var homeData: HomeViewModel
     var animation: Namespace.ID

     var body: some View {
         VStack {
             HStack(spacing: 15) {
                 if !homeData.startAnimation {
                     Image("shoe")
                         .resizable()
                         .aspectRatio(contentMode: .fit)
                         .matchedGeometryEffect(id: "SHOE", in: animation)
                 }

                 VStack(alignment: .trailing, spacing: 10) {
                     Text("Air Max Exosense 'Atomic Powder'")
                         .fontWeight(.semibold)
                         .foregroundColor(.gray)
                         .multilineTextAlignment(.trailing)

                     Text("$270.00")
                         .fontWeight(.bold)
                         .foregroundColor(.black)
                 }
             }
             .padding()

             Divider()

             Text("SELECT SIZE")
                 .font(.callout)
                 .fontWeight(.semibold)
                 .foregroundColor(.gray)
                 .padding(.vertical)

             // Sizes
             let colums = Array(repeating: GridItem(.flexible(), spacing: 😎, count: 4)

             LazyVGrid(columns: colums, alignment: .leading, spacing: 15, content: {
                 ForEach(sizes, id: \.self) { size in
                     Button(action: {
                         withAnimation {
                             homeData.selectedSize = size
                         }
                     }, label: {
                         Text(size)
                             .fontWeight(.semibold)
                             .foregroundColor(homeData.selectedSize == size ? .white : .black)
                             .padding(.vertical)
                             .frame(maxWidth: .infinity)
                             .background(homeData.selectedSize == size ? Color("orange") : Color.black.opacity(0.06))
                             .cornerRadius(10)
                     })
                 }
             })
             .padding(.top)

             // Add to cart button
             Button(action: {
                 withAnimation(.easeInOut(duration: 0.7)) {
                     homeData.startAnimation.toggle()
                 }
             }, label: {
                 Text("Add to cart")
                     .fontWeight(.bold)
                     .foregroundColor(homeData.selectedSize == "" ? .black : .white)
                     .padding(.vertical)
                     .frame(maxWidth: .infinity)
                     .background(homeData.selectedSize == "" ? Color.black.opacity(0.06) : Color("orange"))
                     .cornerRadius(18)
             })
             // disable button when no size selected
             .disabled(homeData.selectedSize == "")
             .padding(.top)
         }
         .padding()
         .background(Color.white.clipShape(CustomCorner(corners: [.topLeft, .topRight], radius: 35)))
     }
 }

 */
