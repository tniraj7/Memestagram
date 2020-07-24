import Foundation
import SwiftUI

struct NotificationView: View {
    
    init() {
        UITableView.appearance().separatorStyle = .none
    }
    
    var body: some View {
        
        NavigationView {
            List {
                ForEach(0..<20) { num in
                    NotificationCell_Like()
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                }
                
            }
            .navigationBarTitle("Notifications")
        }
    }
}

struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView()
    }
}
