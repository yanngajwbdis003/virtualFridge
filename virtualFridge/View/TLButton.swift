//
//  TLButton.swift
//  virtualFridge
//
//  Created by Monica Yang on 2024-05-18.
//


import SwiftUI

struct TLButton: View {
    let title: String
    let background: Color
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        }label: {
            ZStack {
                RoundedRectangle(cornerRadius: 7)
                    .foregroundColor(background)
                Text(title)
                    .foregroundColor(Color.white)
                    .bold()
            }
        }
        .padding()
    }
}


#Preview {
    TLButton(title: "Value", background: .pink) {
        
    }
}

