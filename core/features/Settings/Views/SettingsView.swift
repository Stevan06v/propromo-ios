import SwiftUI

struct SettingsView: View {
    @State private var email: String = ""
    @State private var oldPassword: String = ""
    @State private var newPassword: String = ""
    @State private var monitorToken: String = ""
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    @State private var selection = "Red"
    let colors = ["Red", "Green", "Blue", "Black", "Tartan"]
    
    @ObservedObject private var settingsViewModel: SettingsViewModel = SettingsViewModel()

    

    init(settingsViewModel: SettingsViewModel){
        _settingsViewModel = ObservedObject(wrappedValue: SettingsViewModel(settingsViewModel: settingsViewModel))
    }
    

    var body: some View {
        NavigationView {
            Form {
                // Email Section
                Section(header: Text("Update Email").font(.headline).padding(.bottom, 5)) {
                    TextField("New Email", text: $email)
                        .textFieldStyle(TextFieldPrimaryStyle())
                        .autocapitalization(.none)

                    Button(action: {
                        updateEmail()
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
                
                // Password Section
                Section(header: Text("Update Password").font(.headline).padding(.bottom, 5)) {
                    SecureField("Old Password", text: $oldPassword)
                        .textFieldStyle(TextFieldPrimaryStyle())
                    SecureField("New Password", text: $newPassword)
                        .textFieldStyle(TextFieldPrimaryStyle())
                    
                    Button(action: {
                        updatePassword()
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
                
              
                Section(header: Text("Update Monitor Token").font(.headline).padding(.bottom, 5)) {
                    
                    Picker("Select a paint color", selection: $selection) {
                                    ForEach(colors, id: \.self) {
                                        Text($0)
                                    }
                                }
                                .pickerStyle(.menu)
                    
                    TextField("Monitor Token", text: $monitorToken)
                        .textFieldStyle(TextFieldPrimaryStyle())
                    
                    Button(action: {
                        updateMonitorToken()
                    }) {
                        Text("Update Monitor Token")
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
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Update"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
            .padding(.top)
        }
    }
    
    private func updateEmail() {
        // Add logic to update email here
        // On success or failure, set showAlert and alertMessage appropriately
        alertMessage = "Email updated successfully"
        showAlert = true
    }
    
    private func updatePassword() {
        // Add logic to update password here
        // On success or failure, set showAlert and alertMessage appropriately
        alertMessage = "Password updated successfully"
        showAlert = true
    }
    
    private func updateMonitorToken() {
        // Add logic to update monitor token here
        // On success or failure, set showAlert and alertMessage appropriately
        alertMessage = "Monitor token updated successfully"
        showAlert = true
    }
}

#Preview {
    SettingsView()
}
