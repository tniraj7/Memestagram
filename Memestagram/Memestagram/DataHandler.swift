import Foundation
import SwiftUI
import Firebase


class DataHandler: ObservableObject {
    
    @Published var homePagePost = [Post]()
    
    init() { self.loadHomePagePosts() }
    
    func loadHomePagePosts() {
        let ref = Database.database().reference()
        ref.child("posts").observe(.value) { (snapshot) in
            for snap in snapshot.children.allObjects as! [DataSnapshot] {
                guard let dict = snap.value as? [String : AnyObject]  else { return }
                self.homePagePost.append(handlePostDictionary(dict: dict))
                self.homePagePost.sort { $0.date!.compare($1.date!) == .orderedDescending }
            }
        }
    }
}
