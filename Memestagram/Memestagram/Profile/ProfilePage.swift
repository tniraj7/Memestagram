import SwiftUI
import SDWebImageSwiftUI

struct ProfileView: View {
    
    @ObservedObject var dataHandler: DataHandler
    @Binding var isLoggedIn: Bool
    
    var currentUser: UserObject
    
    var body: some View {
        NavigationView {
            
            if currentUser == self.dataHandler.loggedInUser {
                VStack {
                    ProfileHeaderView(currentUser: currentUser)
                    QGrid(self.dataHandler.profilePagePosts, columns: 3, columnsInLandscape: nil, vSpacing: 0, hSpacing: 0, vPadding: 0, hPadding: 0, isScrollable: true, showScrollIndicators: false, content: { post in
                        
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
                .navigationBarItems(trailing: NavigationLink(destination: SettingsView(dataHandler: self.dataHandler, isLoggedIn: self.$isLoggedIn),label: { Image(systemName: "slider.horizontal.3") .accentColor(.black)}))
                .navigationBarTitle("Profile", displayMode: .inline)
            } else {
                VStack {
                    ProfileHeaderView(currentUser: currentUser)
                    QGrid(self.dataHandler.TemporaryPosts, columns: 3, columnsInLandscape: nil, vSpacing: 0, hSpacing: 0, vPadding: 0, hPadding: 0, isScrollable: true, showScrollIndicators: false, content: { post in
                        
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
        }.onAppear{
            self.dataHandler.loadPostsFor(currentUser.id)
        }
    }
}
