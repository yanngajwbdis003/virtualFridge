//
//  FridgeViewModel.swift
//  virtualFridge
//
//  Created by Monica Yang on 2024-01-04.
//
import SwiftUI

class FridgeViewModel: ObservableObject {
    @Published var items : [UserItem] = [UserItem(name: "carrot"), UserItem(name: "potato"), UserItem(name: "ice cream")]
    
    @Published var isItemClicked: Bool = false

    func addItem(item: UserItem) {
        items.append(item)
      
    }
    
    func removeItem(item: UserItem) {
        if let indexToRemove = items.firstIndex(of: item) {
            items.remove(at: indexToRemove)
        } else {
            
        }
    }
    
    func clickedItem() {
        isItemClicked = true
    }
    
    
    
    
}


