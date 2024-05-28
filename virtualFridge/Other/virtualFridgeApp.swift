//
//  virtualFridgeApp.swift
//  virtualFridge
//
//  Created by Monica Yang on 2024-01-04.
//
import FirebaseCore
import SwiftUI

@main
struct virtualFridgeApp: App {
    let persistenceController = PersistenceController.shared
    init(){
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
