import SwiftUI

struct SinglePostView: View {
    
    var currentPost: Post
    
    var body: some View {
        
        List {
            PostCell(currentPost: self.currentPost)
            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            
        }.onAppear {
            UITableView.appearance().separatorStyle = .none
        }
    }
}
