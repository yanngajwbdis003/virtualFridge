//
//  FridgeItemView.swift
//  virtualFridge
//
//  Created by Monica Yang on 2024-01-04.
//

import SwiftUI


struct FridgeItemView: View {
    @Binding var item: UserItem
    @ObservedObject private var viewModel: FridgeItemViewModel
    
    init(item: Binding<UserItem>) {
        self._item = item
        self.viewModel = FridgeItemViewModel(item: item.wrappedValue)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Edit Item")
                    .bold()
                    .font(.system(size: 30))
                
                Form {
                    
                    TextField("Name", text: $viewModel.newName)
                    DatePicker("Expiary Date", selection: $viewModel.newExpirationDate)
                    TextField("Description", text: $viewModel.newDescription)
                    
                    
                    HStack {
                        Button("Save") {
                            viewModel.updateInfo(to: &item)
                        }
                        .padding()
                        
                        Spacer()
                        
                        NavigationLink(destination: FridgeView()) {
                            Text("Cancel")
                        }
                        .isDetailLink(false)
                        .padding
                    
                    }
                    .padding(.horizontal)
                }
            }
            
        }
        
    }
}

struct FridgeItem_Previews : PreviewProvider {
    static var previews : some View {
        let carrot = UserItem(name: "Carrot")
        FridgeItemView(item: .constant(carrot))
    }
}
