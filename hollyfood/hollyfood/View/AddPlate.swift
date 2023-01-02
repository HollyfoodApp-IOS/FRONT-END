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

    @ObservedObject var translation = Translation()
    @State var Plate_Name : String = ""
    @State var Enter_Plate_Name : String = ""
    @State var Price : String = ""
    @State var Enter_Plate_Price : String = ""
    @State var Category : String = ""
    @State var Add_Plate : String = ""
    @State var Error : String = ""
    @State var Message : String = ""
    @State var plateNameVerification : String = ""
    @State var Plate_price_invalid : String = ""
    @State var Plate_Added_Successfully : String = ""
    @State var fieldsEmptyMessage : String = ""

    var body: some View {
        
        ZStack{
            
            ZStack(alignment: .topTrailing) {
                
                VStack{
                    
                    GeometryReader{_ in
                        
                        VStack{
                            
                            VStack(alignment: .leading, spacing: 10){
                                
                                
                                Text(Plate_Name)
                                    .font(.system(size: 18))
                                    .fontWeight(.bold)
                                    .foregroundColor(Color("GrayColor"))
                                    .padding(.top, 30)
                                
                                TextField(Enter_Plate_Name, text: $plateViewModel.name)
                                    .padding()
                                    .background(Color("LightColor"))
                                    .cornerRadius(5)
                                    .shadow(color: Color("DarkColor").opacity(0.1), radius: 5, x: 0, y: 5)
                                    .shadow(color: Color("DarkColor").opacity(0.08), radius: 5, x: 0, y: -5)
                                    .font(.system(size: 20))
                                
                                Text(Price)
                                    .font(.system(size: 18))
                                    .fontWeight(.bold)
                                    .foregroundColor(Color("GrayColor"))
                                    .padding(.top, 10)
                                
                                TextField(Enter_Plate_Price, text: $plateViewModel.price)
                                    .padding()
                                    .background(Color("LightColor"))
                                    .cornerRadius(5)
                                    .shadow(color: Color("DarkColor").opacity(0.1), radius: 5, x: 0, y: 5)
                                    .shadow(color: Color("DarkColor").opacity(0.08), radius: 5, x: 0, y: -5)
                                    .font(.system(size: 20))

                                
                                Text(Category)
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
                            
                                Text(Add_Plate)
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
                        .onAppear(perform: {
                            translation.Translate()
                            Plate_Name = translation.Plate_Name
                            Enter_Plate_Name = translation.Enter_Plate_Name
                            Price = translation.Price
                            Enter_Plate_Price = translation.Enter_Plate_Price
                            Category = translation.Category
                            Add_Plate = translation.Add_Plate
                            Error = translation.Error
                            Message = translation.Message
                            plateNameVerification = translation.plateNameVerification
                            Plate_price_invalid = translation.Plate_price_invalid
                            Plate_Added_Successfully = translation.Plate_Added_Successfully
                            fieldsEmptyMessage = translation.fieldsEmptyMessage
                        })

                    }
                }
            }
            
            if self.alert
            {
                PopupView(alert: self.$alert, title: self.$title, message: self.$message)
            }
            
        }
        .navigationTitle(Add_Plate)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func verify(){
        
        if plateViewModel.name != "" && plateViewModel.price != "" {
            
            if plateViewModel.name.count < 4 {
                self.title = Error
                self.message = plateNameVerification
                self.alert.toggle()
                return
            }
            
            price = Float(plateViewModel.price) ?? 0
            
            if price == 0 {
                
                self.title = Error
                self.message = Plate_price_invalid
                self.alert.toggle()
                return
            }

            
            plateViewModel.addPlate(plate: Plate(id:"", name: plateViewModel.name, category: selectedCategory, price: price, image: selectedCategory, restaurant: restaurant), onSuccess: {
                
                self.title = Message
                self.message = Plate_Added_Successfully
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
            self.title = Error
            self.message = fieldsEmptyMessage
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
