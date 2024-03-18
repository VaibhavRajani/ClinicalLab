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
                
                VStack(spacing: 10) {
                    Image("parkway")
                        .resizable()
                        .frame(maxWidth: 400, maxHeight: 400)
                    
                    HStack{
                        Text("Username: ")
                            .foregroundStyle(Color.customPink)
                        TextField("Username", text: $viewModel.user.username)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    .padding()
                    

                    HStack{
                        Text("Password: ")
                            .foregroundStyle(Color.customPink)
                        SecureField("Password", text: $viewModel.user.password)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    .padding()
                   
                    
                    if let errorMessage = viewModel.errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .padding()
                    }
                    
                    Button("Login") {
                        viewModel.login()
                    }
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.customPink)
                    .cornerRadius(8)
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

#Preview {
    AdminLoginView(viewModel: AdminLoginViewModel())
}


