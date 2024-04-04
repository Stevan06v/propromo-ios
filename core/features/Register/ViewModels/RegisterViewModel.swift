
import SwiftUI
class RegisterViewModel: ObservableObject{
    
    @AppStorage("AUTH_KEY") var authenticated: Bool = false
    
    @AppStorage("USER_KEY") var email: String = ""
    @Published var name: String = ""
    @Published var password: String = ""
    @Published var retypedPassword: String = ""
    @Published var invalid: Bool = false

    
    init() {
        //print("Currently registered: \(authenticated)")
        //print("Current User: \(email)")
    }

    
    func toggleRegistration() {
        self.password = ""
        withAnimation {
            authenticated.toggle()
        }
    }
    
    func register() {
        print("true");
    }
    
    func registerPressed() {
        print("Register Pressed")
    }
}
