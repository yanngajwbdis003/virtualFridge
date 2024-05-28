//
//  User.swift
//  virtualFridge
//
//  Created by Monica Yang on 2024-01-04.
//

import SwiftUI
import FirebaseFirestoreSwift


struct User: Codable, Identifiable {
    @DocumentID var id: String?
    var name: String
    var userFridge: [String]

}




