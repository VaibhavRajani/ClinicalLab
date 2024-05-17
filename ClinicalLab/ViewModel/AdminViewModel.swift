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
    
    private var loginService: LoginService
    var onLoginSuccess: (() -> Void)?
    
    init(loginService: LoginService) {
         self.loginService = loginService
         if let savedUsername = UserDefaults.standard.string(forKey: "savedUsername") {
             user.username = savedUsername
             if let savedPassword = KeychainHelper.shared.getPassword(for: savedUsername) {
                 user.password = savedPassword
             }
         }
     }
    
    private var cancellables = Set<AnyCancellable>()
    
    func login() {
        isLoggingIn = true
        errorMessage = nil
        
        loginService.login(user: user)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoggingIn = false
                if case let .failure(error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            }, receiveValue: { [weak self] isSuccess in
                if isSuccess {
                    self?.isAuthenticated = true
                    self?.onLoginSuccess?()
                    UserDefaults.standard.set(self?.user.username, forKey: "savedUsername")
                    KeychainHelper.shared.savePassword(self?.user.password ?? "", for: self?.user.username ?? "")
                    if let fetchedPassword = KeychainHelper.shared.getPassword(for: self?.user.username ?? "") {
                                        print("Fetched decrypted password: \(fetchedPassword)")
                                    }
                    print("Login successful")
                } else {
                    self?.errorMessage = "Login failed"
                    print("Login not successful")
                }
            })
            .store(in: &self.cancellables)
    }
}
