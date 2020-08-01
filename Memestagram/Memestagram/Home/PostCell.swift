import SwiftUI
import SDWebImageSwiftUI

struct PostCell: View {
    
    var currentPost: Post
    @Environment(\.imageCache) var cache: ImageCache
    
    var body: some View {
        VStack {
            VStack {
                
                if URL(string: self.currentPost.imageUrl) != nil {
                    AnimatedImage(url:  URL(string: self.currentPost.imageUrl))
                            .onFailure { error in
                                
                            }
                            .resizable()
                            .placeholder(UIImage(systemName: "photo"))
                            .placeholder {
                                Rectangle().foregroundColor(Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)))
                            }
                            .indicator(SDWebImageActivityIndicator.medium)
                            .transition(.fade)
                            .scaledToFit()
                }
                
                HStack {
                    Image("boats")
                        .resizable()
                        .frame(width: 50, height: 50, alignment: .center)
                        .cornerRadius(25)
                    
                    VStack(alignment: .leading) {
                        Text("Build That App")
                        
                        Text(self.currentPost.date?.formatDate() ?? "")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    
                    Spacer()
                }.padding()
                
                Divider().padding(.horizontal)
                
                Text(self.currentPost.comment)
                    .frame( maxWidth: .infinity, alignment: .leading)
                    .lineLimit(nil)
                    .padding()
            }
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 1)
            .padding()
        }
    }
}

struct PostCell_Previews: PreviewProvider {
    static var previews: some View {
        PostCell(currentPost: Post()).previewDevice("iPhone 11")
    }
}
