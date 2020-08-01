import SwiftUI

struct PostCell: View {
    
    var currentPost: Post
    @Environment(\.imageCache) var cache: ImageCache
    
    var body: some View {
        VStack {
            VStack {
                
                if URL(string: self.currentPost.imageUrl) != nil {
                    AsyncImage(
                        url: URL(string: self.currentPost.imageUrl)!,
                        cache: self.cache, placeholder: Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)), configuration: {
                            $0.resizable()
                                .frame(height: (UIScreen.main.bounds.width - 20) * CGFloat(currentPost.aspectRatio),
                                       alignment: .center) as! Image
                            
                        }
                    )
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
