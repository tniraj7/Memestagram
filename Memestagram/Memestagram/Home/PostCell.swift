import SwiftUI

struct PostCell: View {
    var i: Int
    
    var body: some View {
        VStack {
            Text("\(i)")
        }
    }
}

struct PostCell_Previews: PreviewProvider {
    static var previews: some View {
        PostCell(i: 1)
    }
}
