import SwiftUI
import Firebase

struct LoginView: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isPresented: Bool = false
    @Binding var isLoggedIn: Bool
    
    var body: some View {
        
        VStack {
            
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.purple, .blue]), startPoint: .leading,
                               endPoint: .trailing)
                    .frame(height: 200, alignment: .top)
                    .edgesIgnoringSafeArea(.top)
                    .shadow(radius: 15)
                
                Text("Memestagram")
                    .foregroundColor(.white)
                    .bold()
                    .font(.largeTitle)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            }
            
            TextField("Email", text: self.$email).padding()
            SecureField("Password", text: self.$password).padding()
            
            Button(action: self.login , label:  {
                Text("Submit")
                .bold()
                    .foregroundColor(.white)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 50, maxHeight: 50, alignment: .center)
            })
            .background(Color.blue)
            .cornerRadius(5)
            .padding()
            
            HStack {
                Text("Don't have an account ?")
                Button(action: self.signUp, label: { Text(" Sign up now!") })
            }
            Spacer()
        }.sheet(isPresented: self.$isPresented, content: {
            SignupView(isPresented: self.$isPresented, isLoggedIn: self.$isLoggedIn)
        })
        
    }
    
    func login() {
        Auth.auth().signIn(withEmail: self.email, password: self.password) { (result, error) in
            if error == nil {
                let user = UserObject()
                user.id = result?.user.uid ?? ""
                user.isLoggedIn.value = true
                user.writeToRealm()
                self.isLoggedIn = true
            } else {
                print(error?.localizedDescription)
            }
        }
    }
    
    func signUp() { self.isPresented.toggle() }
}
