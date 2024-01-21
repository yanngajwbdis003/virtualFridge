//
//  FridgeItemViewModel.swift
//  virtualFridge
//
//  Created by Monica Yang on 2024-01-04.
//

import SwiftUI

class FridgeItemViewModel : ObservableObject {
    var item: UserItem
    @Published var newName: String = ""
    @Published var newExpirationDate: Date = Date()
    @Published var newDescription: String = ""
    
    init (item: UserItem) {
        self.item = item
        self.newName = item.name
        self.newExpirationDate = item.expirationDate
        self.newDescription = item.description
    }
    
    func updateInfo(to item: inout UserItem) {
        item.name = newName
        item.expirationDate = newExpirationDate
        item.description = newDescription
    }
    
    
    
    
}
