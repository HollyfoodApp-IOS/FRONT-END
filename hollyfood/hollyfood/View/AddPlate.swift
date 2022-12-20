//
//  AddPlate.swift
//  hollyfood
//
//  Created by Khairi on 3/12/2022.
//

import SwiftUI

struct AddPlate: View {
    
    @Binding var restaurant : String
    @ObservedObject var plateViewModel = PlateViewModel()
    @State var alert = false
    @State var title = ""
    @State var message = ""
    @State var selectedCategory : String = "Pizza"
    @State var price : Float = 0

    var body: some View {
        
        ZStack{
            
            ZStack(alignment: .topTrailing) {
                
                VStack{
                    
                    GeometryReader{_ in
                        
                        VStack{
                            
                            VStack(alignment: .leading, spacing: 10){
                                
                                
                                Text("Name")
                                    .font(.system(size: 18))
                                    .fontWeight(.bold)
                                    .foregroundColor(Color("GrayColor"))
                                    .padding(.top, 30)
                                
                                TextField("Enter Plate Name", text: $plateViewModel.name)
                                    .padding()
                                    .background(Color("LightColor"))
                                    .cornerRadius(5)
                                    .shadow(color: Color("DarkColor").opacity(0.1), radius: 5, x: 0, y: 5)
                                    .shadow(color: Color("DarkColor").opacity(0.08), radius: 5, x: 0, y: -5)
                                    .font(.system(size: 20))
                                
                                Text("Price")
                                    .font(.system(size: 18))
                                    .fontWeight(.bold)
                                    .foregroundColor(Color("GrayColor"))
                                    .padding(.top, 10)
                                
                                TextField("Enter Plate Price", text: $plateViewModel.price)
                                    .padding()
                                    .background(Color("LightColor"))
                                    .cornerRadius(5)
                                    .shadow(color: Color("DarkColor").opacity(0.1), radius: 5, x: 0, y: 5)
                                    .shadow(color: Color("DarkColor").opacity(0.08), radius: 5, x: 0, y: -5)
                                    .font(.system(size: 20))

                                
                                Text("Category")
                                    .font(.system(size: 18))
                                    .fontWeight(.bold)
                                    .foregroundColor(Color("GrayColor"))
                                    .padding(.top, 10)
                                
                                /*Picker(
                                 selection: $selectedCategory,
                                 label:
                                 
                                 HStack {
                                 Text("Category:")
                                 Text(selectedCategory)
                                 }
                                 .padding()
                                 .background(Color.red)
                                 .cornerRadius(5)
                                 .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
                                 .shadow(color: Color.black.opacity(0.08), radius: 5, x: 0, y: -5)
                                 .font(.system(size: 20))
                                 ,
                                 content: {
                                 ForEach(categories, id: \.self)
                                 { category in
                                 Text(category)
                                 .font(.system(size: 100))
                                 
                                 }
                                 
                                 }
                                 )
                                 .pickerStyle(MenuPickerStyle())*/
                                
                                
                                Picker("Choose a category", selection: $selectedCategory){
                                    ForEach(addPlateCategories, id: \.self)
                                    { category in
                                        Text(category)
                                    }
                                }
                                .pickerStyle(.wheel)
                                .padding(.top, -30)
                                                                                        
                                
                            }
                            .padding(.horizontal, 25)
                            .padding(.top, 25)
                            
                            
                            Button(action: {
                                self.verify()
                            })
                            {
                                
                                Text("Add Plate")
                                    .font(.system(size: 20))
                                    .foregroundColor(.white)
                                    .fontWeight(.bold)
                                    .padding(.vertical)
                                    .frame(width: UIScreen.main.bounds.width - 50)
                                    .background(
                                        LinearGradient(gradient: .init(colors: [Color("PrimaryColor"), Color("PrimaryColor")]), startPoint: .topLeading, endPoint: .bottomTrailing)
                                    )
                                
                            }
                            .cornerRadius(8)
                            .padding(.horizontal, 25)
                            .padding(.top, 25)
                        }
                    }
                }
            }
            
            if self.alert
            {
                PopupView(alert: self.$alert, title: self.$title, message: self.$message)
            }
            
        }
        .navigationTitle("Add Plate")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func verify(){
        
        if plateViewModel.name != "" && plateViewModel.price != "" {
            
            if plateViewModel.name.count < 4 {
                self.title = "Error"
                self.message = "The plate name must be at least 4 letters"
                self.alert.toggle()
                return
            }
            
            price = Float(plateViewModel.price) ?? 0
            
            if price == 0 {
                
                self.title = "Error"
                self.message = "Plate price invalid"
                self.alert.toggle()
                return
            }

            
            plateViewModel.addPlate(plate: Plate(id:"", name: plateViewModel.name, category: selectedCategory, price: price, image: selectedCategory, restaurant: restaurant), onSuccess: {
                
                self.title = "Information"
                self.message = "Plate Added Successfully!"
                self.alert.toggle()
                plateViewModel.name = ""
                plateViewModel.price = ""
                return

            },
            onError: {
                
                return
                                
            })

        }
        
        else {
            self.title = "Error"
            self.message = "Please fill all the contents properly"
            self.alert.toggle()
            
        }

    }

}

struct AddPlate_Previews: PreviewProvider {
    static var previews: some View {
        Tab()
    }
}


var addPlateCategories = ["Pizza", "Sandwich", "Pasta", "Plate", "Other"]
