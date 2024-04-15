//
//  ContentView.swift
//  ClinicalLab
//
//  Created by Vaibhav Rajani on 2/12/24.
//

import Foundation
import SwiftUI

struct ContentView: View {
    @StateObject var loginViewModel = AdminLoginViewModel(loginService: LoginService())
    
    var body: some View {
        if loginViewModel.isAuthenticated {
            MainTabView()
                .environmentObject(loginViewModel)
        } else {
            AdminLoginView(viewModel: loginViewModel)
        }
    }
}
