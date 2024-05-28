//
//  FridgeItemViewModel.swift
//  virtualFridge
//
//  Created by Monica Yang on 2024-01-04.
//

import SwiftUI

class FridgeItemViewModel : ObservableObject {
    @Binding var item: UserItem
    @Published var newName: String = ""
    @Published var newExpirationDate: Date = Date()
    @Published var newDescription: String = ""
    @Published var shouldNavigate: Bool = false;
    
    init (item: Binding<UserItem>) {
        self._item = item
        self.newName = item.wrappedValue.name
        self.newExpirationDate = item.wrappedValue.expirationDate
        self.newDescription = item.wrappedValue.description
    }
    
    func updateInfo(to item: inout UserItem) {
        item.name = newName
        item.expirationDate = newExpirationDate
        item.description = newDescription
    }
    
    
    
    
}
