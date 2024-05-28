//
//  FridgeView.swift
//  virtualFridge
//
//  Created by LOGIN on 2024-01-09.
//

import SwiftUI

struct FridgeView: View {
    let dateFormatter = DateFormatter()
    @ObservedObject var viewModel = FridgeViewModel()
    
    init() {
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.setLocalizedDateFormatFromTemplate("MMMd")
    }
    
    var body: some View {
        NavigationView {
            VStack {
                
                Text("Your Virtual Fridge :)")
                    .bold()
                    .font(.system(size: 30))

                List(viewModel.items, id: \.self) { item in
                    NavigationLink(destination: FridgeItemView(item:.constant(item)).navigationBarBackButtonHidden(true)){
                        HStack {
                            Text(item.name)
                            Spacer()
                            Text(dateFormatter.string(from: item.expirationDate))
                        }
                    }
                }
                
            }
            

        }
    
    }
}



struct FridgeView_Previews: PreviewProvider {
    
    
    static var previews: some View {
        FridgeView()
    }
}
