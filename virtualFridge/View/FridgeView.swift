//
//  FridgeView.swift
//  virtualFridge
//
//  Created by LOGIN on 2024-01-09.
//

import SwiftUI

struct FridgeView: View {
    @ObservedObject var viewModel = FridgeViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                
                List(viewModel.items, id: \.self) { item in
                    NavigationLink(destination: FridgeItemView(item:.constant(item))){
                        HStack {
                            Text(item.name)
                            Spacer()
                            Text(item.expirationDate.formatted())
                        }
                    }
                }
                
            }
            .navigationTitle("Your Virtual Fridge :)")
        }
    
    }
}

struct FridgeView_Previews: PreviewProvider {
    
    
    static var previews: some View {
        FridgeView()
    }
}
