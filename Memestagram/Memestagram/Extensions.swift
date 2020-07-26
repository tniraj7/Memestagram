import Foundation
import RealmSwift

extension ISO8601DateFormatter {
    convenience init(_ formatOptions: Options, timeZone: TimeZone = TimeZone(secondsFromGMT: 0)!) {
        self.init()
        self.formatOptions = formatOptions
        self.timeZone = timeZone
    }
}

extension Formatter {
    static let iso8601 = ISO8601DateFormatter([.withInternetDateTime, .withFractionalSeconds])
}

extension Date {
    var iso8601: String { return Formatter.iso8601.string(from: self) }
}

extension String {
    var iso8601: Date? { return Formatter.iso8601.date(from: self) }
}

extension Object {
    
    func writeToRealm() {
        
        try! uiRealm.write({
            uiRealm.add(self, update: .all)
        })
    }
    
    func updateToRealm() {
        
        try! uiRealm.write({
            uiRealm.add(self, update: .modified)
        })
    }
}

func handlePostDictionary(dict: [String: AnyObject]) -> Post {
    
    let post = Post()
    post.id = dict["id"] as? String  ?? ""
    post.comment = dict["comment"] as? String ?? ""
    post.date = (dict["date"] as? String ?? "").iso8601
    post.aspectRatio = dict["aspectRatio"] as? Double ?? 1.0
    post.imageUrl = dict["imgageUrl"] as? String ?? ""
    post.writeToRealm()
    
    return post
}
