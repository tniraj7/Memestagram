import SwiftUI

struct LoginView: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isPresented: Bool = false
    
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
            HStack {
                Text("Don't have an account ?")
                Button(action: self.signUp, label: { Text(" Sign up now!") })
            }
            Spacer()
        }.sheet(isPresented: self.$isPresented, content: {
            SignupView(isPresented: self.$isPresented)
        })
        
    }
    
    func signUp() { self.isPresented.toggle() }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
