import Foundation
import SwiftUI
import Firebase


class DataHandler: ObservableObject {
    
    @Published var homePagePosts = [Post]()
    @Published var explorePagePosts = [PostIdentifiable]()
    @Published var searchPosts = [Post]()
    @Published var loggedInUser = UserObject()
    @Published var TemporaryPosts = [PostIdentifiable]()
    @Published var profilePagePosts = [PostIdentifiable]()
    
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
    
    func loadPostsFor(_ user: String) {
        
        if user == loggedInUser.id {
            let ref = Database.database().reference()
            ref.child("posts").queryOrdered(byChild: "uid").queryEqual(toValue: user).observe(.value) { (snapshot) in
                for snap in snapshot.children.allObjects as! [DataSnapshot] {
                    guard let dict = snap.value as? [String : AnyObject]  else { return }
                    self.profilePagePosts.append(PostIdentifiable(post: handlePostDictionary(dict: dict)))
                    self.profilePagePosts.sort { $0.post.date!.compare($1.post.date!) == .orderedDescending }
                }
            }
        } else {
            
            let ref = Database.database().reference()
            ref.child("posts").queryOrdered(byChild: "uid").queryEqual(toValue: user).observe(.value) { (snapshot) in
                for snap in snapshot.children.allObjects as! [DataSnapshot] {
                    guard let dict = snap.value as? [String : AnyObject]  else { return }
                    self.TemporaryPosts.append(PostIdentifiable(post: handlePostDictionary(dict: dict)))
                    self.TemporaryPosts.sort { $0.post.date!.compare($1.post.date!) == .orderedDescending }
                }
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
