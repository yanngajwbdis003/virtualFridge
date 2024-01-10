//
//  LogInView.swift
//  virtualFridge
//
//  Created by Monica Yang on 2024-01-04.
//

import SwiftUI

struct LogInView: View {
    
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        VStack {
            HeaderView(title: "Your Virtual Fridge!", subtitle: "reduce food waste", menuColor: Color.green)
            
            Form {
                TextField("Email Address", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
        }
        
    }
}

struct LogInView_Previews : PreviewProvider {
    static var previews : some View {
        LogInView()
    }
}
