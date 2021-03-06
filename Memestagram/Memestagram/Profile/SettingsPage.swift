import SwiftUI
import Firebase
import RealmSwift

struct SettingsView: View {
    
    @ObservedObject var dataHandler : DataHandler
    @State private var isPresented: Bool =  false
    @State private var image: Image?
    @State private var uiImage: UIImage?
    
    @State private var username: String = ""
    @Binding var isLoggedIn: Bool
    
    var body: some View {
        VStack {
            HStack {
                
                if self.image != nil {
                    self.image!
                        .resizable()
                        .frame(width: 80, height: 80, alignment: .center)
                        .aspectRatio(contentMode: .fill)
                        .clipped()
                        .cornerRadius(40)
                } else {
                    Image(systemName: "folder.circle.fill")
                        .frame(width: 80, height: 80, alignment: .center)
                        .aspectRatio(contentMode: .fill)
                        .clipped()
                        .background(Color.gray)
                        .cornerRadius(40)
                }
                
                Spacer()
                
                Button(action: self.choosePhoto , label:  { Text("Choose Photo") })
                
            }.padding()
            
            TextField(
                "Username",
                text: $username,
                onEditingChanged: {  changed in
               
                }, onCommit: { self.submitNewUsername() }
            ).padding()
            
            Button(action: self.submit , label:  {
                Text("Submit")
                .bold()
                    .foregroundColor(.white)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 50, maxHeight: 50, alignment: .center)
            })
            .background(Color.blue)
            .cornerRadius(5)
            .padding()
            
            Spacer()
            
            Button(action: self.logout , label:  {
                Text("Logout")
                .bold()
                    .foregroundColor(.white)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 50, maxHeight: 50, alignment: .center)
            })
            .background(Color.red)
            .cornerRadius(5)
            .padding()
        }
        .sheet(isPresented: self.$isPresented, content: {
            ImagePicker(isShown: self.$isPresented, image: self.$image, uiImage: self.$uiImage)
        })
    }
    
    func choosePhoto() {
        self.isPresented.toggle()
    }
    
    func submitNewUsername() {
        if username == "" {
            
        } else {
            
        }
    }
    
    func submit() {
        guard let imageData = uiImage?.jpegData(compressionQuality: 0.1) else { return }
        let ref = Storage.storage().reference().child("users").child(self.dataHandler.loggedInUser.id)
        ref.putData(imageData, metadata: nil) { (metadata, error) in
            if error == nil {
                ref.downloadURL { (url, error) in
                    if error == nil {
                        Database.database().reference().child("users").child(self.dataHandler.loggedInUser.id).updateChildValues(["profileImageUrl" : url?.absoluteString ?? ""])
                        
                        try! uiRealm.write({
                            self.dataHandler.loggedInUser.profileImageUrl = url?.absoluteString ?? ""
                        })
                    }
                }
            } else {
                print(error)
            }
        }
    }
    
    func logout() {
        self.isLoggedIn = false
        try! Auth.auth().signOut()
        try! uiRealm.write({ 
            uiRealm.deleteAll()
        })
    }
}
