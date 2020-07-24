import SwiftUI

struct PostCell: View {
    var i: Int
    
    var body: some View {
        VStack {
            VStack {
                Image("boats")
                    .resizable()
                    .frame(height: 600, alignment: .center)
                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.25), radius: 10, x: 2, y: 2)
                
                HStack {
                    Image("boats")
                        .resizable()
                        .frame(width: 50, height: 50, alignment: .center)
                        .cornerRadius(25)
                    
                    VStack(alignment: .leading) {
                        Text("Build That App")
                        
                        Text("1 hr ago")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    
                    Spacer()
                }.padding()
                
                Divider().padding(.horizontal)
                
                Text("eafeajfhbeafeahbfhaebfheab hjaebfjhbeafbhebfjaeb  feahjbfebjaef")
                    .lineLimit(nil)
                    .padding()
            }
            .background(Color.white)
            .cornerRadius(20)
            .shadow(radius: 10)
            .padding()
        }
    }
}

struct PostCell_Previews: PreviewProvider {
    static var previews: some View {
        PostCell(i: 1).previewDevice("iPhone 11")
    }
}
