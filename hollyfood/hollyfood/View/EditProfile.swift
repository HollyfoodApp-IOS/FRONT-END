//
//  EditProfile.swift
//  hollyfood
//
//  Created by Khairi on 21/11/2022.
//

import SwiftUI

struct EditProfile: View {
    
    @ObservedObject var viewModel = UserViewModel()
    @State var alert = false
    @State var error = ""

    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct EditProfile_Previews: PreviewProvider {
    static var previews: some View {
        EditProfile()
    }
}
