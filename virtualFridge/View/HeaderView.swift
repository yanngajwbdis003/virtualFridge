//
//  HeaderView.swift
//  virtualFridge
//
//  Created by Eojin Lee on 2024-01-10.
//

import SwiftUI

struct HeaderView: View {
    let title: String
    let subtitle: String
    let bgColor: Color
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 0)
                .foregroundColor(bgColor)
            
            VStack {
                Text(title)
                    .font(.system(size:45))
                    .foregroundColor(Color.white)
                    .bold()
                
                Text(subtitle)
                    .font(.system(size:30))
                    .foregroundColor(Color.white)
            }
        }
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(title: "ExampleTitle",
                   subtitle: "example subtitle",
                   bgColor: Color.green)
    }
}
