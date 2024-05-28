//
//  FoodItem.swift
//  virtualFridge
//
//  Created by Monica Yang on 2024-05-16.
//

import Foundation
import FirebaseFirestoreSwift
import Firebase

struct Food: Codable, Identifiable {
    @DocumentID var id: String? // Firestore document ID
    var name: String
    var type: String
    var length: Int // Days till expiration
    var calories: Int
}
