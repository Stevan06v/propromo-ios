//
//  SettingsViewModel.swift
//  Propromo
//
//  Created by Stevan Vlajic on 06.06.24.
//

import Foundation
class SettingsViewModel: ObservableObject {
    
    
    @Published private var email: String = ""
    @Published private var oldPassword: String = ""
    @Published private var newPassword: String = ""
    @Published private var monitorToken: String = ""
    @Published private var showAlert: Bool = false
    @Published private var alertMessage: String = ""
    @Published private var selection = "Red"
    
    
    @Published public var monitorsModel: MonitorsModel = MonitorsModel()
    @Published public var settingsViewModel: SettingsViewModel = SettingsViewModel()
    
    
    
    
    
    
    
    
    
}
