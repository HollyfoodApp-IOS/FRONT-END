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

    var body: some View {
        
        VStack{
            
            HStack{
                (
                    Text("Scan ")
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    +
                    Text("QR Code")
                        .foregroundColor(.gray)
                )
                .font(.largeTitle)
                .padding()
                
            }
            .padding()

            Image(uiImage: generateQRCode(text))
                .interpolation(.none)
                .resizable()
                .frame(width: 150, height: 150, alignment: .center)
        }
        .navigationTitle("QR Code Menu")
        .navigationBarTitleDisplayMode(.inline)
        .background(Color.white.ignoresSafeArea())

        
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
