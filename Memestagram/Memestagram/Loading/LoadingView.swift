import SwiftUI

struct LoadingView: View {
    
    @EnvironmentObject var dataHandler: DataHandler
    
    @State var isLoggedIn: Bool = false
    @State var isLoaded: Bool = false
    
    
    var body: some View {
        
        Group {
            
            if isLoaded == false {
                Text("Memestagram").bold().font(.largeTitle)
                
            } else {
                if isLoggedIn {
                    TabViewController(dataHandler: self.dataHandler)
                } else {
                    LoginView()
                }
            }
            
        }.onAppear {
            self.dataHandler.checkIfLoggedIn { (isLoggedIn) in
                
                if isLoggedIn {
                    self.isLoggedIn = true
                } else {
                    self.isLoggedIn = false
                }
                self.isLoaded = true
            }
        }
        
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
