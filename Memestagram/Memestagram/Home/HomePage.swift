import SwiftUI

struct HomeView: View {
    
    @ObservedObject var dataHandler: DataHandler
    private var navBarTitle = "Memestagram"
    
    init(dataHandler: DataHandler) {
        UITableView.appearance().separatorStyle = .none
        self.dataHandler = dataHandler
    }

    
    var body: some View {
        NavigationView {
            List {
                ForEach(self.dataHandler.homePagePost, id: \.id) { post in
                    PostCell(currentPost: post)
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                }
            }.navigationBarTitle(navBarTitle, displayMode: .inline)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(dataHandler: DataHandler()).previewDevice("iPhone 11")
    }
}
