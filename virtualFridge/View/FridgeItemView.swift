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
        self.viewModel = FridgeItemViewModel(item: item)
    }
    
    var body: some View {
        NavigationView {
            
            VStack {
                Text("Edit Item")
                    .bold()
                    .font(.system(size: 30))
                
                Form {
                    
                    TextField("Name", text: $viewModel.newName)
                    
                    DatePicker(
                        "Expiry Date",
                            selection: $viewModel.newExpirationDate,
                            displayedComponents: [.date]
                        )
                    TextField("Description", text: $viewModel.newDescription)
                    
                    Button("Save") {
                        viewModel.updateInfo(to: &item)
                        viewModel.shouldNavigate = true
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                 
                    if viewModel.shouldNavigate {
                        NavigationLink(destination: FridgeView().navigationBarBackButtonHidden(true), isActive: $viewModel.shouldNavigate) {
                            EmptyView()
                        }
                        .hidden()
                    }
                    
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
