import SwiftUI

struct ProfileHeaderView: View {
    var body: some View {
        HStack {
            VStack {
                Image("wily")
                    .resizable()
                    .frame(width: 80, height: 80, alignment: .center)
                    .cornerRadius(40)
                Text("Wily Coyote").font(.footnote)
            }
            Spacer()
            VStack {
                Text("Followers").font(.callout)
                Text("45K").font(.caption).bold()
            }
            Spacer()
            VStack {
                Text("Following").font(.callout)
                Text("200").font(.caption).bold()
            }
            Spacer()
        }.padding()
    }
}

struct Header_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHeaderView()
    }
}
