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
                                    .foregroundColor(.gray)
                                    .padding(.top, 30)
                                
                                TextField("Enter Plate Name", text: $selectedPlate.name)
                                    .padding()
                                    .background(Color.white)
                                    .cornerRadius(5)
                                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
                                    .shadow(color: Color.black.opacity(0.08), radius: 5, x: 0, y: -5)
                                    .font(.system(size: 20))
                                
                                Text("Price")
                                    .font(.system(size: 18))
                                    .fontWeight(.bold)
                                    .foregroundColor(.gray)
                                    .padding(.top, 10)
                                
                                TextField("Enter Plate Price", text: $price)
                                    .padding()
                                    .background(Color.white)
                                    .cornerRadius(5)
                                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
                                    .shadow(color: Color.black.opacity(0.08), radius: 5, x: 0, y: -5)
                                    .font(.system(size: 20))
                                
                                
                                Text("Category")
                                    .font(.system(size: 18))
                                    .fontWeight(.bold)
                                    .foregroundColor(.gray)
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
                                Text("Edit Plate")
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
            .onAppear(perform: {
                price = String(format: "%.2f", selectedPlate.price)
            })
            
            if self.alert
            {
                
                PopupView(alert: self.$alert, title: self.$title, message: self.$message)
            }
            
        }
        .navigationTitle("Edit Plate")
        .navigationBarTitleDisplayMode(.inline)
        
    }
    
    func verify(){
        
        
        if selectedPlate.name != "" && price != "" {
            
            selectedPlate.price = Float(price) ?? 0

            if selectedPlate.name.count < 4 {
                
                self.title = "Error"
                self.message = "The plate name must be at least 4 letters"
                self.alert.toggle()
                return
            }
            
            if selectedPlate.price == 0 {
                
                self.title = "Error"
                self.message = "Plate price invalid"
                self.alert.toggle()
                return
            }

            
            plateViewModel.editPlate(plate: selectedPlate) {
                
                self.title = "Information"
                self.message = "Plate Edited Successfully"
                self.alert.toggle()
                return
            }
        }
        
        else {
            
            self.title = "Error"
            self.message = "Please fill all the contents properly"
            self.alert.toggle()
            
        }

    }

}

struct EditPlate_Previews: PreviewProvider {
    static var previews: some View {
        Tab()
    }
}
