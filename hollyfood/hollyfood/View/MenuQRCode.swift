//
//  MenuQRCode.swift
//  hollyfood
//
//  Created by Khairi on 11/12/2022.
//

import SwiftUI
import Foundation
import CoreImage.CIFilterBuiltins

struct MenuQRCode: View {
    
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    @Binding var text : String 
    @Binding var restaurantName : String
    
    @ObservedObject var translation = Translation()
    @State var Scan : String = ""
    @State var QR_Code : String = ""
    @State var Menu_QR_Code : String = ""

    var body: some View {
        
        VStack{
            
            HStack{
                (
                    Text(Scan)
                        .fontWeight(.bold)
                        .foregroundColor(Color("DarkColor"))
                    +
                    Text(" "+QR_Code)
                        .foregroundColor(Color("GrayColor"))
                )
                .font(.largeTitle)
                .padding()
                
            }
            .padding()

            Image(uiImage: generateQRCode(text))
                .interpolation(.none)
                .resizable()
                .frame(width: 150, height: 150, alignment: .center)
                .background(Color.white.ignoresSafeArea())

        }
        .navigationTitle(Menu_QR_Code)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear(perform: {
            
            translation.Translate()
            Scan = translation.Scan
            QR_Code = translation.QR_Code
            Menu_QR_Code = translation.Menu_QR_Code
        })

        
    }
    
    func generateQRCode(_ str : String) -> UIImage {
        
        print("qr code TEXT")
        print(str)

        let data = Data(str.utf8)
        filter.setValue(data, forKey: "inputMessage")
        
        if let qrCodeImage = filter.outputImage{
            
            if let qrCodeCGImage = context.createCGImage(qrCodeImage, from: qrCodeImage.extent) {
                return UIImage(cgImage: qrCodeCGImage)
            }
        }
            
        return UIImage(systemName: "xmark") ?? UIImage()
    }
}

struct MenuQRCode_Previews: PreviewProvider {
    static var previews: some View {
        Tab()
    }
}
