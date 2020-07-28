import SwiftUI

struct TabViewController: View {
    
    @EnvironmentObject var dataHandler: DataHandler
    
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
            
            ProfileView(dataHandler: dataHandler).tabItem {
                Image(systemName: "person.circle.fill")
                Text("Profile")
            }.tag(4)
            
        }.accentColor(.black)
    }
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        TabViewController()
    }
}
