//
//  LogInView.swift
//  virtualFridge
//
//  Created by Monica Yang on 2024-01-04.
//

import SwiftUI

struct LogInView: View {
    
    @StateObject var viewModel = LogInViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                HeaderView(title: "My Fridge", subtitle: "reduce waste", bgColor: .green)
                
            
            Form {
                if !viewModel.errorMessage.isEmpty {
                    Text(viewModel.errorMessage)
                        .foregroundColor(Color.red)
                }
                TextField("Email Address", text: $viewModel.email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                SecureField("Password", text: $viewModel.password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                TLButton(title: "Log In", background: .blue) {
                    viewModel.login()
                    }
                    .padding()
                }
                

            
            VStack {
                Text("New here?")
                NavigationLink("Create An Account",
                               destination: RegisterView())
            
            }
            
            Spacer()
            }
        }
    }
}

#Preview {
    LogInView()
}
