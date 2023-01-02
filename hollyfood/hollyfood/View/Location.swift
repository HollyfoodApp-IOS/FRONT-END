//
//  Location.swift
//  hollyfood
//
//  Created by AlaBenRejab on 1/1/2023.
//

import CoreLocation
import CoreLocationUI
import SwiftUI

struct Location: View {
    @StateObject var locationManager = LocationManager()
    @State var long : String=""
    @State var lat : String=""
    
    
    var body: some View {
        NavigationView {
            VStack {
                
                    Image("location")
                        .resizable()
                        .scaledToFit()
                
                    Text("Hi, nice to meet you !")
                        .font(.title)
                        .bold()
                        .foregroundColor(Color("DarkColor"))

                    Text("Choose your location to find \nrestraurants around you. ")
                        .font(.title3)
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                        .padding(.all, 20)
                        .foregroundColor(Color("GrayColor"))

                    NavigationLink(
                        destination: Tab().navigationBarBackButtonHidden(true).navigationBarHidden(true),
                        //destination: RestaurantsView(long: long, lat: lat).navigationBarBackButtonHidden(true).navigationBarHidden(true),
                        label: {
                            HStack {
                                Image(systemName: "location.fill")
                                    .foregroundColor(Color(#colorLiteral(red: 0.9580881, green: 0.10593573, blue: 0.3403331637, alpha: 1)))
                                
                                Text("Use current location")
                                    .bold()
                                    .foregroundColor(Color(#colorLiteral(red: 0.9580881, green: 0.10593573, blue: 0.3403331637, alpha: 1)))
                                
                            }
                            .frame(width: 300, height: 60, alignment: .center)
                            .border(Color(#colorLiteral(red: 0.9580881, green: 0.10593573, blue: 0.3403331637, alpha: 1)), width: 3)
                            .cornerRadius(5)
                        })
                VStack {
                    if let location = locationManager.location {

                        let lat = location.latitude
                        let long = location.longitude
                        
                               /* long="\(location.longitude)"
                                lat="\(location.latitude)"*/
                                
                                
                            }
                            LocationButton {
                                locationManager.requestLocation()
                                
                                print(lat)
                               
                            }
                    
                            .frame(width: 300, height: 60, alignment: .center)
                            .bold()
                            
                        }
             
                    
                    /*Text("Select Manually")
                        .bold()
                        .underline()
                        .foregroundColor(.gray)
                        .padding(.top, 80)
                    Spacer()*/
                    
            }
        }

    }
    
}

struct Location_Previews: PreviewProvider {
    static var previews: some View {
        Location()
    }
}
