//
//  NewItemView.swift
//  virtualFridge
//
//  Created by LOGIN on 2024-01-09.
//

import SwiftUI

struct NewItemView: View {
    @StateObject var viewModel = NewItemViewModel()
    
    var body: some View {
        
        VStack {
            Text("New Item")
                .bold()
                .font(.system(size: 30))
            
            Form {
                
                TextField("Item Name", text: $viewModel.name)

                
                DatePicker(
                    "Expiry Date",
                        selection: $viewModel.expiaryDate,
                        displayedComponents: [.date]
                    )
                
                Button("Save") {
                    viewModel.save()
                }
               
            }
        }
    }
}

struct NewItemView_Previews: PreviewProvider {
    static var previews: some View {
        NewItemView()
    }
}
