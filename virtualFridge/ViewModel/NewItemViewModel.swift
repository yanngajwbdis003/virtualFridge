//
//  NewItemViewModel.swift
//  virtualFridge
//
//  Created by Monica Yang on 2024-01-04.
//

import Foundation

class NewItemViewModel: ObservableObject {
    @Published var name = ""
    // Date contains time of day as well but we dont want that
    // not sure how to exclude, but the init date should be the one that is already in the
    // database we initialize. unless its a user created item, then it should be todays date
    
    @Published var expiaryDate = Date()
    
    init() {}
    
    func save() {
        
    }
}


