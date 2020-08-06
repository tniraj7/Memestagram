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
                if isLoggedIn == true  {
                    TabViewController(dataHandler: self.dataHandler, isLoggedIn: self.$isLoggedIn)
                } else {
                    LoginView(isLoggedIn: self.$isLoggedIn)
                }
            }
            
        }.onAppear() {
            self.dataHandler.checkIfLoggedIn { (isLoggedIn) in
                
                if isLoggedIn == true {
                    self.isLoggedIn = true
                } else {
                    self.isLoggedIn = false
                }
                self.isLoaded = true
            }
        }
        
    }
}
