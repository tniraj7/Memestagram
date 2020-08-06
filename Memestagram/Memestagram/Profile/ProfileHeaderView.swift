import SwiftUI

struct ProfileHeaderView: View {
    
    var currentUser: UserObject
    
    var body: some View {
        HStack {
            VStack {
                Image("wily")
                    .resizable()
                    .frame(width: 80, height: 80, alignment: .center)
                    .cornerRadius(40)
                Text(currentUser.username).font(.footnote)
            }
            Spacer()
            VStack {
                Text("Followers").font(.callout)
                Text("\(currentUser.followers.count)").font(.caption).bold()
            }
            Spacer()
            VStack {
                Text("Following").font(.callout)
                Text("\(currentUser.followings.count)").font(.caption).bold()
            }
            Spacer()
        }.padding()
    }
}
