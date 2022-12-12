//
//  Menu.swift
//  hollyfood
//
//  Created by Khairi on 30/11/2022.
//

import SwiftUI
import LocalAuthentication

struct Menu: View {
    
    @Binding var restaurant : String
    @Binding var restaurantName : String

    @ObservedObject var plateViewModel = PlateViewModel()
    @StateObject var cartData = CartViewModel()

    @State var addPlate = false
    @State var goToCart = false
    @State var goToQRCode = false

    @State var selectedCategory = categories[0]
    @Namespace var animation

    @State var show = false
    @State var selectedPlate : Plate = initialPlate[0]
        
    @State var qrCodeText : String = ""
    @State var i : Int = 1
    
    @State var alert = false
    @State var title = ""
    @State var message = ""

    var body: some View {
        
        ZStack(alignment: .bottom){
            
            VStack{
                
                HStack{
                    
                    VStack(alignment: .leading, spacing: 5, content: {
                        Text(restaurantName)
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
                                    MenuQRCode(text: $qrCodeText, restaurantName: $restaurantName)
                            .environmentObject(cartData)
                            .navigationBarBackButtonHidden(false),
                        isActive: $goToQRCode) {

                        Button(action: {
                            
                            goToQRCodeFaceID()
                            
                        }, label: {
                            Image(systemName: "qrcode.viewfinder")
                                .font(.title3)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color("PrimaryColor"))
                                .clipShape(Circle())
                        })
                    }
                    
                    NavigationLink(destination:
                        Cart(restaurant: $restaurant, restaurantName: $restaurantName)
                            .environmentObject(cartData)
                            .navigationBarBackButtonHidden(false),
                        isActive: $goToCart) {
                        
                        Button(action: {
                            goToCart = true
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
                
                //Categories
                ScrollView(.horizontal) {
                    
                    HStack(spacing: 20) {
                        
                        ForEach(categories, id: \.self) { tab in
                            
                            Button(action: {
                                withAnimation(.spring()) {
                                    selectedCategory = tab
                                }
                                
                                plateViewModel.getPlatesByRestaurant(restaurant: restaurant, category: selectedCategory)

                            }, label: {
                                            
                            Text(tab)
                                .font(.system(size: 15))
                                .fontWeight(.bold)
                                .foregroundColor(selectedCategory == tab ? .white : .black)
                                .padding(.vertical, 10)
                                .padding(.horizontal, selectedCategory == tab ? 20 : 0)
                                .background(
                                    ZStack {
                                        if selectedCategory == tab {
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

                            ForEach(plateViewModel.plates) { plate in

                                PlateItem(plate: plate, animation: animation)
                                    .onTapGesture {
                                        withAnimation(.spring()) {
                                            selectedPlate = plate
                                            //show.toggle()
                                            cartData.showCart.toggle()
                                        }
                                    }
                            }
                    }
                    .onAppear(perform:{
                        plateViewModel.getPlatesByRestaurant(restaurant: restaurant, category: selectedCategory)
                    })
                    .padding()
                    
                    NavigationLink(destination: AddPlate(restaurant: $restaurant).navigationBarBackButtonHidden(false), isActive: $addPlate) {
                        
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
            
            AddToCart(selectedPlate: $selectedPlate, restaurantID: $restaurant, animation: animation)
                .environmentObject(cartData)
                .environmentObject(plateViewModel)
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
                    
                    if !cartData.deleteAnimation
                    {
                        Image(systemName: "bag\(cartData.addPlateToCart ? ".fill" : "")")
                            .font(.title)
                            .foregroundColor(.white)
                            .padding()
                            .background(cartData.addPlateToCart ? Color.red :
                                Color("PrimaryColor"))
                            .clipShape(Circle())
                            .offset(y: cartData.showBag ? -50 : 300)
                    }
                    else
                    {
                        Image(systemName: "trash\(cartData.addPlateToCart ? ".fill" : "")")
                            .font(.title)
                            .foregroundColor(.white)
                            .padding()
                            .background(cartData.addPlateToCart ? Color.red :
                                Color("PrimaryColor"))
                            .clipShape(Circle())
                            .offset(y: cartData.showBag ? -50 : 300)
                    }
                }
                .frame(width: rect.width)
                .offset(y: cartData.endAnimation ? 500 : 0)
            }
            
            if self.alert{
                PopupView(alert: self.$alert, title: self.$title, message: self.$message)
            }

        }
        .navigationTitle("Menu")
        .navigationBarTitleDisplayMode(.inline)
        .background(Color.white.ignoresSafeArea())
        .onChange(of: cartData.endAnimation, perform: { value in
            
            if cartData.endAnimation {
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [self] in
                    
                    withAnimation {
                        cartData.showCart.toggle()
                    }

                    cartData.startAnimation = false
                    cartData.deleteAnimation = false
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
    
    func goToQRCodeFaceID(){
        
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error){
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "This is for security reasons"){ success,
                AuthentificationError in
                
                if success{
                    
                    qrCodeText = restaurantName+" Menu"
                    
                    plateViewModel.plates.forEach{ plate in
                        
                        qrCodeText += " "
                        qrCodeText += "\n*Plate \(i)"
                        qrCodeText += "\nPlate Name: "+plate.name
                        qrCodeText += "\nPlate Category: "+plate.category
                        qrCodeText += "\nPlate Price: "+String(format: "%.2f DT", plate.price)+" DT"

                        i+=1
                    }
                    
                    i=1
                    
                    goToQRCode = true;

                }
                
            }
        }
        else
        {
            self.title = "Error"
            self.message = "Face ID is required to go to the QR code page"
            self.alert.toggle()
            return

        }
    }


}

struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        Tab()
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
