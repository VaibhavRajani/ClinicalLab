//
//  AdminLoginView.swift
//  ClinicalLab
//
//  Created by Vaibhav Rajani on 2/12/24.
//

import SwiftUI

struct AdminLoginView: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass
    @ObservedObject var viewModel: AdminLoginViewModel

    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                VStack(spacing: 20) {
                    Image("parkway")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: verticalSizeClass == .regular ? 400 : 150)
                    
                    TextField("Username", text: $viewModel.user.username)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal, verticalSizeClass == .regular ? 100 : 50)
                    
                    SecureField("Password", text: $viewModel.user.password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal, verticalSizeClass == .regular ? 100 : 50)
                    
                    if let errorMessage = viewModel.errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .padding()
                    }
                    
                    Button("Login") {
                        viewModel.login()
                    }
                    .buttonStyle(PrimaryButtonStyle()) 
                    .disabled(viewModel.isLoggingIn)
                    .padding()
                }
                
                Spacer()
            }
            .navigationTitle("Admin Login")
            .navigationBarHidden(true)
            .edgesIgnoringSafeArea(.all) // Extend to the edges if needed.
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}


