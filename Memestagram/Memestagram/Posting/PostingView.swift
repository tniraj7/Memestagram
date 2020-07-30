import SwiftUI
import RealmSwift
import Firebase

struct PostingView: View {
    
    @State private var description: String = ""
    @State private var isPresented: Bool =  false
    @State private var image: Image?
    @State private var uiImage: UIImage?
    
    @ObservedObject var dataHandler: DataHandler
    
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
                        .frame( height: 150, alignment: .leading)
                    
                }.padding()
                
                Spacer()
                
                Button(action: self.submit , label:  {
                    Text("Post")
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
        guard let imageData = uiImage?.jpegData(compressionQuality: 0.08) else { return }
        let postId = UUID().uuidString
        let ref = Storage.storage().reference().child("posts").child(postId)
        
        ref.putData(imageData, metadata: nil) { (metadata, error) in
            if error == nil {
                ref.downloadURL { (url, error) in
                    if error == nil {
                        let imageHeight = self.uiImage?.size.height ?? 0
                        let imageWidth = self.uiImage?.size.width ?? 0
                        let aspectRatio = Double(imageHeight / imageWidth)
                        
                        Database.database().reference().child("posts").child(postId)
                            .updateChildValues([
                                "imageUrl": url?.absoluteString ?? "",
                                "id": postId,
                                "comment": self.description,
                                "aspectRatio" : aspectRatio,
                                "date" : Date().iso8601
                            ])
                    }
                }
            } else {
                print(error?.localizedDescription)
            }
        }
    }
}

struct PostingPage_Previews: PreviewProvider {
    static var previews: some View {
        PostingView(dataHandler: DataHandler())
    }
}
