import SwiftUI

struct TabViewController: View {
    
    @ObservedObject var dataHandler: DataHandler
    @Binding var isLoggedIn: Bool
    
    @State private var selected: Int = 0
    
    var body: some View {
        
        TabView(selection: $selected) {
            
            HomeView(dataHandler: dataHandler).tabItem {
                Image(systemName: "house.fill")
                Text("Home")
            }.tag(0)
            
            ExploreView(dataHandler: dataHandler).tabItem {
                Image(systemName: "bolt.circle.fill")
                Text("Explore")
            }.tag(1)
            
            PostingView(dataHandler: dataHandler).tabItem {
                Image(systemName: "arrowtriangle.up.circle.fill")
                Text("Post")
            }.tag(2)
            
            
            NotificationView(dataHandler: dataHandler).tabItem {
                Image(systemName: "tray.fill")
                Text("Notifications")
            }.tag(3)
            
            ProfileView(dataHandler: dataHandler, isLoggedIn: self.$isLoggedIn, currentUser: self.dataHandler.loggedInUser).tabItem {
                Image(systemName: "person.circle.fill")
                Text("Profile")
            }.tag(4)
            
        }.accentColor(.black)
    }
}
