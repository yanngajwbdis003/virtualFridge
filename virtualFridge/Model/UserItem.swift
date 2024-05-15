//
//  UserItem.swift
//  virtualFridge = frdige Item
//
//  Created by Monica Yang on 2024-01-04.
//
// https://stackoverflow.com/questions/24089999/how-do-you-create-a-swift-date-object


import SwiftUI

struct UserItem: View {
    let name: String
    let expirationDate: Date
    var quantity: Int
    var timeUntilExpiration : Int
    var isExpired: Bool
    
    var body: some View {
        Text("hi :)")
    }
    
    mutating func updateIsExpired() {
        if timeUntilExpiration <= 0 {
            isExpired = true
        }
    }
}

