//
//  AuthenticationView.swift
//  Propromo
//
//  Created by Stevan Vlajic on 16.05.24.
//

import SwiftUI

struct AuthenticationView: View {
    @ObservedObject var authenticationViewModel: AuthenticationViewModel;
    @EnvironmentObject var viewModel: ViewModel
    
    init(){
        _authenticationViewModel = ObservedObject(wrappedValue: AuthenticationViewModel())
    }
    
    var body: some View {
        if(authenticationViewModel.showLogin){
            LogInView(viewModel: viewModel)
                .environmentObject(self.authenticationViewModel)
                .environmentObject(self.viewModel)
        }else{
            RegistrationView(viewModel: viewModel)
                .environmentObject(self.authenticationViewModel)
                .environmentObject(self.viewModel)
        }
        
    }
}

#Preview {
    AuthenticationView()
}
