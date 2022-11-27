//
//  hollyfoodApp.swift
//  hollyfood
//
//  Created by Khairi on 16/11/2022.
//

import SwiftUI

@main
struct hollyfoodApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
