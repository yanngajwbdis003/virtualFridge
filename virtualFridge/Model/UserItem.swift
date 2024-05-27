//
//  UserItem.swift
//  virtualFridge = frdige Item
//
//  Created by Monica Yang on 2024-01-04.
//
// 

import SwiftUI
import FirebaseFirestoreSwift
import Firebase
import Foundation

struct UserItem: Codable, Identifiable {
    @DocumentID var id: String?
    var quantity: Int
    var isExpired: Bool
    var foodID: String
    var purchaseDate: Date
    // private var db = Firestore.firestore()
    
    //init() {}
    
    
    func fetchFoodLength(foodID: String, completion: @escaping (Int?) -> Void) {
        let db = Firestore.firestore()
        let foodRef = db.collection("Food").document(foodID)
        foodRef.getDocument { document, error in
            guard let document = document, document.exists, let food = try? document.data(as: Food.self) else {
                print("Could not fetch food data or food does not exist")
                completion(nil)
                return
            }
            completion(food.length)
        }
    }
    
    func checkIfItemExpiringSoon(userItem: UserItem, completion: @escaping (Bool) -> Void) {
        
        fetchFoodLength(foodID: userItem.foodID) { length in
            guard let length = length else {
                completion(false)
                return
            }
            
            let calendar = Calendar.current
            let expirationDate = calendar.date(byAdding: .day, value: length, to: userItem.purchaseDate)!
            let today = Date()
            let daysUntilExpiration = calendar.dateComponents([.day], from: today, to: expirationDate).day!
            
            completion(daysUntilExpiration >= 0 && daysUntilExpiration <= 5)
        }
    }

    
    
//
//    var body: some View {
//        Text("hi :)")
//    }
//    
//    mutating func updateIsExpired() {
//        
//    }
}

