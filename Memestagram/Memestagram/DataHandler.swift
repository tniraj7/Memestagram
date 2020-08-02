import Foundation
import SwiftUI
import Firebase


class DataHandler: ObservableObject {
    
    @Published var homePagePosts = [Post]()
    @Published var explorePagePosts = [PostIdentifiable]()
    @Published var searchPosts = [Post]()
    @Published var loggedInUser = UserObject()
    
    init() {
        self.loadHomePagePosts()
        self.loadExplorePagePosts()
    }
    
    func loadHomePagePosts() {
        let ref = Database.database().reference()
        ref.child("posts").observe(.value) { (snapshot) in
            for snap in snapshot.children.allObjects as! [DataSnapshot] {
                guard let dict = snap.value as? [String : AnyObject]  else { return }
                self.homePagePosts.append(handlePostDictionary(dict: dict))
                self.homePagePosts.sort { $0.date!.compare($1.date!) == .orderedDescending }
            }
        }
    }
    
    func loadExplorePagePosts() {
        let ref = Database.database().reference()
        ref.child("posts").observe(.value) { (snapshot) in
            for snap in snapshot.children.allObjects as! [DataSnapshot] {
                guard let dict = snap.value as? [String : AnyObject]  else { return }
                self.explorePagePosts.append(PostIdentifiable(post: handlePostDictionary(dict: dict)))
            }
        }
    }
    
    func loadPostsFrom(keyword: String) {
        self.searchPosts.removeAll()
        let ref = Database.database().reference()
        ref.child("posts").queryOrdered(byChild: "searchTerms/\(keyword)").queryEqual(toValue: true).observeSingleEvent(of: .value, with: { snapshot in
            for snap in snapshot.children.allObjects as! [DataSnapshot] {
                
                guard let dict = snap.value as? [String : AnyObject] else { return }
                
                self.searchPosts.append(handlePostDictionary(dict: dict))
            }
        })
    }
    
    func checkIfLoggedIn(completion: @escaping (_ isLoggedIn: Bool) -> ()) {
        
        guard let userId = Auth.auth().currentUser?.uid else {
            completion(false)
            return
        }
        
        if uiRealm.object(ofType: UserObject.self, forPrimaryKey: userId) != nil {
            let ref = Database.database().reference().child("users")
            ref.child(userId).observeSingleEvent(of: .value) { (snapshot) in
                
                guard let dict = snapshot.value as? [String : AnyObject] else { return }
                self.loggedInUser = handleUserDictionary(dict: dict)
                completion(true)
            }
        } else {
            completion(false)
        }
        
    }
    
}
