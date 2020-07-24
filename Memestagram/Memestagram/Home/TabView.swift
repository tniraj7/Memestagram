import SwiftUI

struct TabViewController: View {
    var body: some View {
        TabViewController {
            HomeView()
        }
    }
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        TabViewController()
    }
}
