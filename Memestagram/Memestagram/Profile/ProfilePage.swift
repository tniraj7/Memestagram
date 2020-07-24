import SwiftUI

struct ProfilePage: View {
    
    var body: some View {
        NavigationView {
            VStack {
                ProfileHeaderView()
                QGrid(exampleData, columns: 3, columnsInLandscape: nil, vSpacing: 0, hSpacing: 0, vPadding: 0, hPadding: 0, isScrollable: true, showScrollIndicators: false, content: { post in
                    
                    post.image
                        .aspectRatio(contentMode: .fill)
                        .frame(width: UIScreen.main.bounds.width / 3,
                               height: UIScreen.main.bounds.height / 3,
                               alignment: .center)
                        .clipped()
                })
            }
            .navigationBarItems(trailing: NavigationLink(destination: SettingsView(),
                            label: { Image(systemName: "slider.horizontal.3") .accentColor(.black)}))
               
            .navigationBarTitle("Profile")
        }
    }
}

struct ProfilePage_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePage()
    }
}
