//
//  UserItem.swift
//  virtualFridge
//
//  Created by Monica Yang on 2024-01-04.
//
// https://stackoverflow.com/questions/24089999/how-do-you-create-a-swift-date-object


import SwiftUI

class UserItem : Equatable, Hashable {
    
    var name: String
    var expirationDate: Date
    var isExpired: Bool
    var description: String
    
    init(name: String, expirationDate: Date, description: String) {
        self.name = name
        self.expirationDate = expirationDate
        self.description = description
        isExpired = false
    }
    
    init(name: String) {
        self.name = name
        self.expirationDate = Date()
        self.description = "description"
        isExpired = false
    }
    
    
    static func == (lhs: UserItem, rhs: UserItem) -> Bool {
        return lhs.name == rhs.name && rhs.expirationDate == lhs.expirationDate
    }
    
    var hash: Int {
        return name.hashValue ^ expirationDate.hashValue
    }
    
    func hash(into hasher: inout Hasher){
        hasher.combine(name)
        hasher.combine(expirationDate)
    }
    
}

