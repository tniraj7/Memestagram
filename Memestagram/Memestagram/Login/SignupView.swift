import SwiftUI
import Firebase

struct SignupView: View {
    
    @State private var email: String  = ""
    @State private var username: String  = ""
    @State private var password1: String  = ""
    @State private var password2: String  = ""
    
    @Binding private var isPresented: Bool
    
    init(isPresented: Binding<Bool>) {
        _isPresented = isPresented
        UITableView.appearance().separatorStyle = .none
    }
    
    var body: some View {
        
        NavigationView {
            
            Form {
                
                Section {
                    TextField("Email", text: self.$email)
                        .frame(width: nil, height: 60, alignment: .center)
                    TextField("Username", text: self.$username)
                        .frame(width: nil, height: 60, alignment: .center)
                    SecureField("Password", text: self.$password1)
                        .frame(width: nil, height: 60, alignment: .center)
                    SecureField("Re-enter password", text: self.$password2)
                        .frame(width: nil, height: 60, alignment: .center)
                }
                
                Section {
                    Button(action: self.submit , label:  {
                        Text("Submit")
                        .bold()
                            .foregroundColor(.white)
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 50, maxHeight: 50, alignment: .center)
                    })
                    .background(Color.black)
                    .cornerRadius(5)
                    .padding()
                }
            
                }
                
            .navigationBarTitle("SignUp")
            
        }
    }
    
    func submit() {
        self.isPresented.toggle()
        if password1 == password2 {
            Auth.auth().createUser(withEmail: self.email, password: self.password1) { (result, error) in
                if error == nil {
                    let user = UserObject()
                    user.id = result?.user.uid ?? ""
                    user.username = self.username
                    user.isLoggedIn.value = true
                    user.writeToRealm()
                    
                    
                    let ref = Database.database().reference().child("user")
                    ref.child(user.id).updateChildValues([
                        "uid" : user.id,
                        "username" : self.username
                    ])
                    
                } else {
                    print(error?.localizedDescription)
                }
            }
        }
        
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView(isPresented: .constant(false))
    }
}
