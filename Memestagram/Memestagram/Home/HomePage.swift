import SwiftUI

struct HomeView: View {
    var body: some View {
        List {
            ForEach(0..<3, id: \.self) { num in
                PostCell(i: num)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
