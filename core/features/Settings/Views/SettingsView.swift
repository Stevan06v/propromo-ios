import SwiftUI

struct SettingsView: View {
    @ObservedObject var settingsViewModel: SettingsViewModel

    init() {
        _settingsViewModel = ObservedObject(wrappedValue: SettingsViewModel())
    }

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Update Email").font(.headline).padding(.bottom, 5)) {
                    TextField("New Email", text: Binding(get: {
                        settingsViewModel.newEmail
                    }, set: {
                        settingsViewModel.dataChanged(newEmail: $0)
                    }))
                    .textFieldStyle(TextFieldPrimaryStyle())
                    .autocapitalization(.none)

                    Button(action: {
                        settingsViewModel.updateEmail()
                    }) {
                        Text("Update Email")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    .padding(.top, 10)
                }
                .padding(.vertical, 10)

                Section(header: Text("Update Password").font(.headline).padding(.bottom, 5)) {
                    VStack {
                        SecureField("Current Password", text: Binding(get: {
                            settingsViewModel.oldPassword
                        }, set: {
                            settingsViewModel.dataChanged(oldPassword: $0)
                        }))
                        .textFieldStyle(TextFieldPrimaryStyle())

                        SecureField("New Password", text: Binding(get: {
                            settingsViewModel.newPassword
                        }, set: {
                            settingsViewModel.dataChanged(newPassword: $0)
                        }))
                        .textFieldStyle(TextFieldPrimaryStyle())

                        SecureField("Confirm New Password", text: Binding(get: {
                            settingsViewModel.confirmNewPassword
                        }, set: {
                            settingsViewModel.dataChanged(confirmNewPassword: $0)
                        }))
                        .textFieldStyle(TextFieldPrimaryStyle())
                    }

                    Button(action: {
                        settingsViewModel.updatePassword()
                    }) {
                        Text("Update Password")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    .padding(.top, 10)
                }
                .padding(.vertical, 10)
            }
            .navigationTitle("Settings")
            .alert(isPresented: $settingsViewModel.showAlert) {
                Alert(title: Text("Update"), message: Text(settingsViewModel.alertMessage), dismissButton: .default(Text("OK")))
            }
            .padding(.top)
        }
    }
}

#Preview {
    SettingsView()
}
