//
//  MainViewModel.swift
//  virtualFridge
//
//  Created by Monica Yang
//
import FirebaseAuth
import SwiftUI
import Firebase
import FirebaseFirestore

class MainViewModel: ObservableObject {
    @Published var currentUserId: String = ""
    private var handler: AuthStateDidChangeListenerHandle?
    private var db = Firestore.firestore()
    @Published var userItems: [UserItem] = []
    @Published var expiredSoonItems: [UserItem] = []
    @Published var user: User?
    
    
    init() {
        self.handler = Auth.auth().addStateDidChangeListener {
            [weak self]_, user in DispatchQueue.main.async {
                self?.currentUserId = user?.uid ?? ""
            }
        }
    }
    
    public var isSignedIn: Bool {
        return Auth.auth().currentUser != nil
    }
    
    func fetchUserDetails(userID: String, completion: @escaping (User?) -> Void) {
        db.collection("userGroup").document(userID).getDocument { (document, error) in
            let result = Result {
                try document?.data(as: User.self)
            }
            switch result {
            case .success(let user):
                if let user = user {
                    DispatchQueue.main.async {  // Ensure UI updates are on the main thread
                        self.user = user
                        completion(user)
                    }
                } else {
                    print("User does not exist")
                    completion(nil)
                }
            case .failure(let error):
                print("Error decoding user: \(error)")
                completion(nil)
            }
        }
    }
    
    func fetchFridgeItems(completion: @escaping ([UserItem]) -> Void) {
        if !currentUserId.isEmpty {
            let userGroupRef = db.collection("userGroup").document(currentUserId)
            
            userGroupRef.getDocument { documentSnapshot, error in
                guard let document = documentSnapshot, document.exists else {
                    print("No userGroup found")
                    completion([]) 
                    return
                }
                
                let userFridges: [String] = document.get("userFridge") as? [String] ?? []
                if userFridges.isEmpty {
                    completion([])
                    return
                }

                let group = DispatchGroup()
                var fetchedItems = [UserItem]()
                
                for id in userFridges {
                    group.enter()
                    self.db.collection("UserItem").document(id).getDocument { (document, error) in
                        defer { group.leave() }
                        if let error = error {
                            print("Error fetching document: \(error)")
                            return
                        }
                        
                        do {
                            if let item = try document?.data(as: UserItem.self) {
                                DispatchQueue.main.async {
                                    fetchedItems.append(item)
                                }
                            }
                        } catch {
                            print("Error decoding item: \(error)")
                        }
                    }
                }
                
                group.notify(queue: .main) {
                    self.userItems = fetchedItems  // Store all fetched items in the main storage
                    print("All items fetched: \(self.userItems)")
                    completion(self.userItems)
                }
            }
        } else {
            completion([])
        }
    }

    func fetchExpiredSoonItems(completion: @escaping ([UserItem]) -> Void) {
        fetchFridgeItems { items in
            self.expiredSoonItems = items.filter { $0.isExpired }
            completion(self.expiredSoonItems)
//               let group = DispatchGroup()
//               for item in items {
//                   group.enter()
//                   self.checkIfItemExpiringSoon(userItem: item) { isExpiringSoon in
//                       if isExpiringSoon {
//                           DispatchQueue.main.async {
//                               self.expiredSoonItems.append(item)
//                           }
//                       }
//                       group.leave()
//                   }
//               }
//               group.notify(queue: .main) {
//                   completion(self.expiredSoonItems)
//               }
           }
    }
    
    func fetchFoodLength(foodID: String, completion: @escaping (Int?) -> Void) {
        let foodRef = db.collection("food").document(foodID)
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
        if (!userItem.isExpired) {
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
        completion(true)
    }

}








