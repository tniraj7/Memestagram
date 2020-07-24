import SwiftUI

struct NotificationCell_Like: View {
    
    var body: some View {
        
        VStack {
            HStack(alignment: .top) {
                Image("boats")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 50, height: 50, alignment: .center)
                    .cornerRadius(5)
                
                VStack(alignment: .leading) {
                    Text("Road Runner liked your post")
                        .font(.callout)
                    Text("1 hr ago")
                        .font(.caption)
                }
                Spacer()
            }
            .padding()
        }
        .background(Color.white)
        .cornerRadius(5)
        .shadow(radius: 1)
        .padding()
    }
}

struct NotificationCell_Like_Previews: PreviewProvider {
    static var previews: some View {
        NotificationCell_Like()
    }
}
