import SwiftUI

struct MainView: View {
    @StateObject var viewModel = MainViewModel()
    @State var user: User? //todo: to be removed
    @State private var showingMenu = false
    @State private var userItems: [UserItem] = []
    

    var body: some View {
        if viewModel.isSignedIn, !viewModel.currentUserId.isEmpty {
            content
        } else {
            LogInView()
        }
    }

    var content: some View {
        Group {
            if let user = user {
                userTabView(user: user)
            } else {
                Text("Loading user details...")
                    .onAppear {
                        fetchUserData()
                    }
            }
        }
    }

    private func userTabView(user: User) -> some View {
        NavigationView {
            VStack(alignment: .leading) {
                HStack {
                    Text("Hello \(self.user?.name ?? "hello")")
                        .font(.largeTitle)
                        .padding()
                    Spacer()
                    Button(action: {
                        showingMenu.toggle()
                    }) {
                        Image(systemName: "line.horizontal.3")
                            .imageScale(.large)
                            .padding()
                    }
                }
                
                GroupBox(label: Label("Expiring Soon!", systemImage: "exclamationmark.triangle").foregroundColor(.red)) {
                    List(viewModel.userItems) { item in
                                VStack(alignment: .leading) {
                                    Text("Food ID: \(item.foodID)")
                                    Text("Quantity: \(item.quantity)")
                                    Text("Expired: \(item.isExpired ? "Yes" : "No")")
                                }
                            }
                            .onAppear {
                                viewModel.fetchFridgeItems(){ items in
                                    self.userItems = items
                                }
                    }
                    .padding()
                    .foregroundColor(.primary)
                }
                .padding()
                
                GroupBox(label: Text("Today’s Recommendation")) {
                    Text("Recipe suggestions here")
                        .padding()
                }
                .padding()
                
                Spacer()
            }
            .navigationBarHidden(true)
            .sheet(isPresented: $showingMenu) {
                        MenuView()
                    }
        }
    }
    
    //todo: need to mvoe to ViewModel
    private func fetchUserData() {
        viewModel.fetchUserDetails(userID: viewModel.currentUserId) { fetchedUser in
            DispatchQueue.main.async {
                if let fetchedUser = fetchedUser {
                    self.user = fetchedUser
                    print("User fetched: \(fetchedUser)")
                } else {
                    print("No user found or user details are incomplete.")
                }
            }
        }
    }
}

struct MenuView: View {
    var body: some View {
        NavigationView {
            List {
                Text("View Fridge")
                Text("Edit Fridge")
                Text("Recipe Recommendation")
            }
            .navigationBarTitle("Menu")
        }
    }
}


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
