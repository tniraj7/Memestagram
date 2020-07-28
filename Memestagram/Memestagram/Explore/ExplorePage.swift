import SwiftUI

var exampleData = [
    PostIdentifiable(),PostIdentifiable(),
    PostIdentifiable(),PostIdentifiable(),
    PostIdentifiable(),PostIdentifiable(),
    PostIdentifiable(),PostIdentifiable(),
    PostIdentifiable(),PostIdentifiable(),
    PostIdentifiable(),PostIdentifiable(),
    PostIdentifiable(),PostIdentifiable(),
    PostIdentifiable(),PostIdentifiable(),
    PostIdentifiable(),PostIdentifiable(),
    PostIdentifiable(),PostIdentifiable(),
    PostIdentifiable(),PostIdentifiable(),
    PostIdentifiable(),PostIdentifiable(),
    PostIdentifiable(),PostIdentifiable(),
    PostIdentifiable(),PostIdentifiable(),
    PostIdentifiable(),PostIdentifiable(),
    PostIdentifiable(),PostIdentifiable(),
    PostIdentifiable(),PostIdentifiable(),
    PostIdentifiable(),PostIdentifiable(),
    PostIdentifiable(),PostIdentifiable(),
    PostIdentifiable(),PostIdentifiable(),
    PostIdentifiable(),PostIdentifiable(),
    PostIdentifiable(),PostIdentifiable(),
    PostIdentifiable(),PostIdentifiable(),
    PostIdentifiable(),PostIdentifiable(),
    PostIdentifiable(),PostIdentifiable(),
    PostIdentifiable(),PostIdentifiable(),
    PostIdentifiable(),PostIdentifiable(),
    PostIdentifiable(),PostIdentifiable(),
    PostIdentifiable(),PostIdentifiable(),
]

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
                        ForEach(0..<3, id: \.self) { num in
                            PostCell(currentPost: Post())
                                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                        }
                    }
                } else {
                    QGrid(exampleData, columns: 3, columnsInLandscape: nil, vSpacing: 0, hSpacing: 0, vPadding: 0, hPadding: 0, isScrollable: true, showScrollIndicators: false, content: { post in
                        
                        NavigationLink(destination: SinglePostView(), label:  {
                            post.image
                                .aspectRatio(contentMode: .fill)
                                .frame(width: UIScreen.main.bounds.width / 3,
                                       height: UIScreen.main.bounds.height / 3,
                                       alignment: .center)
                                .clipped()
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
        }
    }
}

struct PostIdentifiable: Identifiable {
    var id = UUID()
    var image = Image("boats").resizable()
    
}

struct ExploreView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreView(dataHandler: DataHandler()).previewDevice("iPhone 11")
    }
}
