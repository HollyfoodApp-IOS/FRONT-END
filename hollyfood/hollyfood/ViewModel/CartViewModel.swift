//
//  CartViewModel.swift
//  hollyfood
//
//  Created by Khairi on 3/12/2022.
//

import Foundation
import SwiftUI

class CartViewModel: ObservableObject {
    
    @Published var cart = [Orderline]()
    
    @Published var showCart = false
    @Published var startAnimation = false
    @Published var deleteAnimation = false
    @Published var imageAnimation = false
    @Published var showBag = false
    @Published var saveCart = false
    @Published var addPlateToCart = false
    @Published var endAnimation = false
    @Published var count = 0

    
    /*@Published var cart = [
        Orderline(id: "1", quantity: 1, price: 10, plateId: "", orderId: "", plateName: "Pizza Neptune", plateCategory: "Pizza", plateImage: "Pizza", offset: 0, isSwiped: false),
        
        Orderline(id: "2", quantity: 1, price: 10, plateId: "", orderId: "", plateName: "Makloub", plateCategory: "Sandwich", plateImage: "Sandwich", offset: 0, isSwiped: false)

    ]*/
    
    func performAnimations() {
        
        withAnimation(.easeOut(duration: 0.8)) {
            imageAnimation.toggle()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
            withAnimation(.easeInOut) {
                self.showBag.toggle()
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
            withAnimation(.easeInOut(duration: 0.5)) {
                self.saveCart.toggle()
            }
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.1) {
            self.addPlateToCart.toggle()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.25) {
            withAnimation(.easeInOut(duration: 0.5)) {
                self.endAnimation.toggle()
            }
        }
    }
}

