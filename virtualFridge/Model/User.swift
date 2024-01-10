//
//  User.swift
//  virtualFridge
//
//  Created by Monica Yang on 2024-01-04.
//

import SwiftUI

struct User: View {
    var username: String
    var email: String
    var password: String
    
    var body: some View {
        Text("Hey! github commit test!! :))")
        Text("smile? ")
    }
    
    init(username: String, email:String, password: String) {
        self.username = username
        self.email = email
        self.password = password
    }
    
    static func newUser(username: String, email:String, password: String) -> User {
        return User(username: username, email: email, password: password)
    }
    
    func login(username: String, email:String, password: String) -> Bool {
        return self.username == username && self.password == password
    }
    
    
}




