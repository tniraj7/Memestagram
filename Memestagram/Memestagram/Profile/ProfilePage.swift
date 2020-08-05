import SwiftUI

struct ProfileView: View {
    
    @ObservedObject var dataHandler: DataHandler
    @Binding var isLoggedIn: Bool
    
    var body: some View {
        NavigationView {
            VStack {
                ProfileHeaderView()
//                QGrid(exampleData, columns: 3, columnsInLandscape: nil, vSpacing: 0, hSpacing: 0, vPadding: 0, hPadding: 0, isScrollable: true, showScrollIndicators: false, content: { post in
//                    
//                    NavigationLink(destination: SinglePostView(), label:  {
//                        post.image
//                            .aspectRatio(contentMode: .fill)
//                            .frame(width: UIScreen.main.bounds.width / 3,
//                                   height: UIScreen.main.bounds.height / 3,
//                                   alignment: .center)
//                            .clipped()
//                    }).buttonStyle(PlainButtonStyle())
//                })
            }
            .navigationBarItems(trailing: NavigationLink(destination: SettingsView(isLoggedIn: self.$isLoggedIn),
                                                         label: { Image(systemName: "slider.horizontal.3") .accentColor(.black)}))
                
            .navigationBarTitle("Profile", displayMode: .inline)
        }
    }
}
