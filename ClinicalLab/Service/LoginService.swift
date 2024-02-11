//
//  LoginService.swift
//  ClinicalLab
//
//  Created by Vaibhav Rajani on 2/12/24.
//

import Foundation
import Combine
import Compression
import SwiftUI

enum LoginError: Error {
    case custom(errorMessage: String)
}

class LoginService {
    func login(user: User) -> AnyPublisher<Bool, LoginError> {
        let loginURL = URL(string: "https://gapinternationalwebapi20200521010239.azurewebsites.net/api/User/UserLogin")!
        var request = URLRequest(url: loginURL)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: String] = ["UserName": user.username, "Password": user.password]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { output in
                guard let response = output.response as? HTTPURLResponse,
                      response.statusCode == 200 else {
                    throw LoginError.custom(errorMessage: "Invalid response from server")
                }
                if let mimeType = response.mimeType, mimeType == "application/json; charset=utf-8" {
                    let result = try JSONDecoder().decode([String: String].self, from: output.data)
                    if let resultString = result["Result"], resultString.caseInsensitiveCompare("Success") == .orderedSame {
                        return true // Login successful
                    } else {
                        return false // Login failed
                    }
                } else {
                    let responseString = String(data: output.data, encoding: .utf8)?.lowercased() ?? ""
                    return responseString.contains("success")
                }
            }
            .mapError { error in
                LoginError.custom(errorMessage: error.localizedDescription)
            }
            .eraseToAnyPublisher()
    }
}

struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(.white)
            .padding()
            .background(RoundedRectangle(cornerRadius: 8).fill(Color.red))
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
    }
}
