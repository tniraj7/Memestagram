import SwiftUI

struct HomeView: View {
    var body: some View {
        List {
            ForEach(0..<3, id: \.self) { num in
                PostCell(i: num)
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().previewDevice("iPhone 11")
    }
}
