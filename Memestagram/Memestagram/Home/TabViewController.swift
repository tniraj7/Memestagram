import SwiftUI

struct TabViewController: View {
    
    @State private var selected: Int = 0
    
    var body: some View {
        
        TabView(selection: $selected) {
            
            HomeView().tabItem {
                 Image(systemName: "house.fill")
            }.tag(0)
            
            ExploreView().tabItem {
                 Image(systemName: "bolt.circle.fill")
            }.tag(1)
            
            PostingView().tabItem {
                 Image(systemName: "arrowtriangle.up.circle.fill")
            }.tag(2)
            
            
            NotificationView().tabItem {
                Image(systemName: "tray.fill")
            }.tag(3)
            
            ProfileView().tabItem {
                Image(systemName: "person.circle.fill")
            }.tag(4)
            
        }.accentColor(.black)
    }
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        TabViewController()
    }
}
