import Foundation
import SwiftUI

struct NotificationView: View {
    
    @ObservedObject var dataHandler: DataHandler
    
    var body: some View {
        
        NavigationView {
            List {
                ForEach(0..<20) { num in
                    NotificationCell_Like()
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                }
                
            }
            .navigationBarTitle("Notifications")
        }.onAppear {
            UITableView.appearance().separatorStyle = .none
        }
    }
}

struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView(dataHandler: DataHandler())
    }
}
