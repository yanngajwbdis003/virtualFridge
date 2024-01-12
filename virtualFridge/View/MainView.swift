//
//  MainView.swift
//  virtualFridge
//
//  Created by Monica Yang on 2024-01-04.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationView {
            LogInView()
        }
    }
}

struct MainView_Previews : PreviewProvider {
    static var previews : some View {
        MainView()
    }
}
