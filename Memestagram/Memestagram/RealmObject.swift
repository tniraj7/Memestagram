import Foundation
import RealmSwift

class Post: Object {
    
    @objc dynamic var id: String = ""
    @objc dynamic var imageUrl: String = ""
    @objc dynamic var comment: String = ""
    @objc dynamic var user: UserObject? = nil
    @objc dynamic var aspectRatio: Double = 0
    @objc dynamic var date: Date? = nil
    var isFavorited = RealmOptional<Bool>()
    
    override class func primaryKey() -> String {
        return "id"
    }
}

class UserObject: Object {
    
    @objc dynamic var id: String = ""
    @objc dynamic var username: String = ""
    @objc dynamic var profileImageUrl: String = ""
    
    var isLoggedIn = RealmOptional<Bool>()
    var isFollowing = RealmOptional<Bool>()
    
    override class func primaryKey() -> String {
        return "id"
    }
}
