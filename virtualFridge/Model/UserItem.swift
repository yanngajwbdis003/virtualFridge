//
//  UserItem.swift
//  virtualFridge = frdige Item
//
//  Created by Monica Yang on 2024-01-04.
//
// 

import SwiftUI
import FirebaseFirestoreSwift

struct UserItem: Codable, Identifiable {
    @DocumentID var id: String?
    var quantity: Int
    var isExpired: Bool
    var foodID: String
    var purchaseDate: Date
    
//    var body: some View {
//        Text("hi :)")
//    }
//    
//    mutating func updateIsExpired() {
//        
//    }
}

