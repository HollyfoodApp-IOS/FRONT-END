//
//  EditPlate.swift
//  hollyfood
//
//  Created by Khairi on 12/12/2022.
//

import SwiftUI

struct EditPlate: View {
    
    @Binding var restaurantID : String
    @Binding var selectedPlate: Plate
    @State var price : String = ""
    
    @EnvironmentObject var plateViewModel: PlateViewModel
    @State var alert = false
    @State var title = ""
    @State var message = ""

    @ObservedObject var translation = Translation()
    @State var Plate_Name : String = ""
    @State var Enter_Plate_Name : String = ""
    @State var Price : String = ""
    @State var Enter_Plate_Price : String = ""
    @State var Category : String = ""
    @State var Edit_Plate : String = ""
    @State var Error : String = ""
    @State var Message : String = ""
    @State var plateNameVerification : String = ""
    @State var Plate_price_invalid : String = ""
    @State var Plate_Edited_Successfully : String = ""
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
                                
                                TextField(Enter_Plate_Name, text: $selectedPlate.name)
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
                                
                                TextField(Enter_Plate_Price, text: $price)
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
                                
                                
                                Picker("Choose a category", selection: $selectedPlate.category){
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
                                Text(Edit_Plate)
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
                            Edit_Plate = translation.Edit_Plate
                            Error = translation.Error
                            Message = translation.Message
                            plateNameVerification = translation.plateNameVerification
                            Plate_price_invalid = translation.Plate_price_invalid
                            Plate_Edited_Successfully = translation.Plate_Edited_Successfully
                            fieldsEmptyMessage = translation.fieldsEmptyMessage
                        })

                    }
                }
            }
            .onAppear(perform: {
                price = String(format: "%.2f", selectedPlate.price)
            })
            
            if self.alert
            {
                
                PopupView(alert: self.$alert, title: self.$title, message: self.$message)
            }
            
        }
        .navigationTitle(Edit_Plate)
        .navigationBarTitleDisplayMode(.inline)
        
    }
    
    func verify(){
        
        
        if selectedPlate.name != "" && price != "" {
            
            selectedPlate.price = Float(price) ?? 0

            if selectedPlate.name.count < 4 {
                
                self.title = Error
                self.message = plateNameVerification
                self.alert.toggle()
                return
            }
            
            if selectedPlate.price == 0 {
                
                self.title = Error
                self.message = Plate_price_invalid
                self.alert.toggle()
                return
            }
            
            plateViewModel.editPlate(plate: selectedPlate) {
                
                self.title = Message
                self.message = Plate_Edited_Successfully
                self.alert.toggle()
                return
            }
        }
        
        else {
            
            self.title = Error
            self.message = fieldsEmptyMessage
            self.alert.toggle()
            
        }

    }

}

struct EditPlate_Previews: PreviewProvider {
    static var previews: some View {
        Tab()
    }
}
