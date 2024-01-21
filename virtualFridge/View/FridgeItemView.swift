//
//  FridgeItemView.swift
//  virtualFridge
//
//  Created by Monica Yang on 2024-01-04.
//

import SwiftUI


struct FridgeItemView: View {
    @Binding var item: UserItem
    @State private var newName: String = ""
    @State private var newExpirationDate: Date = Date()
    @State private var newDescription: String = ""
    
    init(item: Binding<UserItem>) {
        self._item = item
        self._newName = State(initialValue: item.wrappedValue.name)
        self._newExpirationDate = State(initialValue: item.wrappedValue.expirationDate)
        self._newDescription = State(initialValue: item.wrappedValue.description)
    }
    
    var body: some View {
        
        VStack {
            Text("Edit Item")
                .bold()
                .font(.system(size: 30))
            
            Form {
                
                TextField("Name", text: $newName)
                DatePicker("Expiary Date", selection: $newExpirationDate)
                TextField("Description", text: $newDescription)
            }
            
//            HStack {
//                Button("save", action: <#T##() -> Void#>)
//                
//                Button("cancel", action: )
//            }
        }
    }
   
    
    
}

struct FridgeItem_Previews : PreviewProvider {
    static var previews : some View {
        let carrot = UserItem(name: "Carrot")
        FridgeItemView(item: .constant(carrot))
    }
}
