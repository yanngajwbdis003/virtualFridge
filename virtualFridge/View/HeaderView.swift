//
//  HeaderView.swift
//  virtualFridge
//
//  Created by LOGIN on 2024-01-09.
//

import SwiftUI

struct HeaderView: View {
    let title: String
    let subtitle: String
    let menuColor: Color
    
    var body: some View {
        ZStack {
            
            RoundedRectangle(cornerRadius: 0)
                .foregroundColor(menuColor)
                
            VStack {
                Text(title)
                    .font(.system(size: 50))
                    .foregroundColor(Color.white)
                    .bold
                
                Text(subtitle)
                    .font(.system(size: 30))
                    .foregroundColor(Color.white)
            }
            
        }
        
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(title: "TITLE", subtitle: "subtitle", menuColor: Blue)
    }
}
