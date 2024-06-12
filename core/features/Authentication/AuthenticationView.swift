import SwiftUI

struct AuthenticationView: View {
    @ObservedObject var authenticationViewModel: AuthenticationViewModel
    @EnvironmentObject var viewModel: ViewModel

    init() {
        _authenticationViewModel = ObservedObject(wrappedValue: AuthenticationViewModel())
    }

    var body: some View {
        if authenticationViewModel.showLogin {
            LogInView(viewModel: viewModel)
                .environmentObject(authenticationViewModel)
                .environmentObject(viewModel)
        } else {
            RegistrationView(viewModel: viewModel)
                .environmentObject(authenticationViewModel)
                .environmentObject(viewModel)
        }
    }
}

#Preview {
    AuthenticationView()
}
