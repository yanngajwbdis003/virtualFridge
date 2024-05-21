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
                    return
                }
                
                let userFridges: [String] = document.get("userFridge") as? [String] ?? []
                let group = DispatchGroup()
                
                for id in userFridges {
                    group.enter()
                    print(id)
                    self.db.collection("UserItem").document(id).getDocument { (document, error) in
                        let result = Result {
                            try document?.data(as: UserItem.self)
                        }
                        switch result {
                        case .success(let item):
                            if let item = item {
                                DispatchQueue.main.async {  // Ensure UI updates are on the main thread
                                    self.userItems.append(item)
                                }
                            } else {
                                print("Item does not exist")
                               
                            }
                        case .failure(let error):
                            print("Error decoding item: \(error)")
                        }
                    }
                }
                group.notify(queue: .main) {
                    completion(self.userItems)
                    print(self.userItems)
                }
                
            }
        }
    }
}








