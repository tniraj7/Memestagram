import SwiftUI

struct PostingView: View {
    
    @State private var description: String = ""
    @State private var isPresented: Bool =  false
    @State private var image: Image?
    @State private var uiImage: UIImage?
    
    var body: some View {
        
        ScrollView {
            VStack {
                HStack {
                    
                    if self.image != nil {
                        self.image!
                        .resizable()
                        .frame(width: 80, height: 80, alignment: .center)
                        .aspectRatio(contentMode: .fill)
                        .clipped()
                        .cornerRadius(5)
                    } else {
                        Image(systemName: "folder.circle.fill")
                             .resizable()
                            .frame(width: 40, height: 40, alignment: .center)
                            .aspectRatio(contentMode: .fill)
                            .clipped()
                            .cornerRadius(5)
                    }
                    
                    Spacer()
                    
                    Button(action: self.choosePhoto , label:  { Text("Choose Photo") })
                    
                }.padding()
                
                VStack(alignment: .leading) {
                    Text("Description").font(.largeTitle).fontWeight(.bold)
                    Text("Type your thoughts").font(.caption).foregroundColor(.gray)
                    
                    MultilineTextView(text: $description)
                        .cornerRadius(5)
                        .frame( height: 100, alignment: .leading)
                    
                }.padding()
                
                Spacer()
                
                Button(action: self.submit , label:  {
                    Text("Submit")
                    .bold()
                        .foregroundColor(.white)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 50, maxHeight: 50, alignment: .center)
                })
                .background(Color.blue)
                .cornerRadius(5)
                .padding()
                
                
                    
            }
        }.sheet(isPresented: self.$isPresented, content: {
            ImagePicker(isShown: self.$isPresented, image: self.$image, uiImage: self.$uiImage)
        })
    }
    
    func choosePhoto() {
        self.isPresented.toggle()
    }
    
    func submit() {
        
    }
}

struct PostingPage_Previews: PreviewProvider {
    static var previews: some View {
        PostingView()
    }
}
