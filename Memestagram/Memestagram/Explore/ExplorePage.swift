import SwiftUI
import SDWebImageSwiftUI

struct ExploreView: View {
    
    @State var searchText = String()
    @State var isSearching: Bool = false
    
    @ObservedObject var dataHandler: DataHandler
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                
                TextField("Enter a keyword", text: self.$searchText, onEditingChanged: { changed in
                    
                }, onCommit: {
                    self.search()
                })
                    .padding()
                
                
                if isSearching {
                    List {
                        ForEach(self.dataHandler.searchPosts, id: \.id) { post in
                            PostCell(currentPost: post)
                                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                        }
                    }
                } else {
                    QGrid(self.dataHandler.explorePagePosts, columns: 3, columnsInLandscape: nil, vSpacing: 0, hSpacing: 0, vPadding: 0, hPadding: 0, isScrollable: true, showScrollIndicators: false, content: { post in
                        
                        NavigationLink(destination: SinglePostView(currentPost: post.post), label:  {
                            
                            AnimatedImage(url:  URL(string: post.post.imageUrl))
                                .onFailure { error in
                                    
                                }
                                .resizable()
                                .placeholder {
                                    Rectangle().foregroundColor(Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)))
                                }
                                .indicator(SDWebImageActivityIndicator.medium)
                                .transition(.fade)
                                .aspectRatio(contentMode: .fill)
                        }).buttonStyle(PlainButtonStyle())
                    })
                }
            }
            .navigationBarTitle("Explore", displayMode: .inline)
        }
    }
    
    func search() {
        if self.searchText == "" {
            self.isSearching = false
        } else {
            self.isSearching = true
            self.dataHandler.loadPostsFrom(keyword: self.searchText.lowercased())
        }
    }
}

struct PostIdentifiable: Identifiable {
    var id = UUID()
    var post: Post
    
}

struct ExploreView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreView(dataHandler: DataHandler()).previewDevice("iPhone 11")
    }
}
