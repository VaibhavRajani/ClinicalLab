//
//  AdminViewModel.swift
//  ClinicalLab
//
//  Created by Vaibhav Rajani on 2/12/24.
//

import Foundation
import Combine

class AdminLoginViewModel: ObservableObject {
    @Published var user: User = User(username: "", password: "")
    @Published var isLoggingIn: Bool = false
    @Published var errorMessage: String?
    @Published var isAuthenticated = false
    
    private var cancellables = Set<AnyCancellable>()
    
    func login() {
        isLoggingIn = true
        errorMessage = nil
        
        LoginService().login(user: user)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                self.isLoggingIn = false
                if case let .failure(error) = completion {
                    self.errorMessage = error.localizedDescription
                }
            }, receiveValue: { isSuccess in
                if isSuccess {
                    self.isAuthenticated = true
                    print("Login successful")
                } else {
                    self.errorMessage = "Login failed"
                    print("Login not successful")
                }
            })
            .store(in: &cancellables)
    }
}
