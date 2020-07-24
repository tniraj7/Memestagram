import SwiftUI

struct NotificationCell_Like: View {
    
    var body: some View {
        
        VStack {
            HStack(alignment: .top) {
                ZStack {
                    Image("wily")
                    .resizable()
                    .renderingMode(.original)
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 50, height: 50, alignment: .center)
                    .cornerRadius(5)
                    
                    NavigationLink(destination: SinglePostView(), label:  {
                        EmptyView()
                    })
                    .buttonStyle(PlainButtonStyle())
                    .cornerRadius(5)
                    .clipped()
                }
                

                
                VStack(alignment: .leading) {
                    Text("Wiley Coyote liked your post")
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
