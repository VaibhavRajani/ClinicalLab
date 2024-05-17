//
//  WebSocketViewModel.swift
//  ClinicalLab
//
//  Created by Vaibhav Rajani on 5/10/24.
//

import SwiftUI
import Combine
import Foundation

class WebSocketViewModel: ObservableObject {
    var webSocketTask: URLSessionWebSocketTask?
    let urlString: String = "wss://example.com/updates" 
    @Published var latestUpdate: String?

    func connect() {
        guard let url = URL(string: urlString) else {
            print("WebSocket URL is invalid")
            return
        }

        let urlSession = URLSession(configuration: .default)
        webSocketTask = urlSession.webSocketTask(with: url)
        webSocketTask?.resume()
        receiveMessage()
    }

    private func receiveMessage() {
        webSocketTask?.receive { [weak self] result in
            switch result {
            case .failure(let error):
                print("Error in receiving message: \(error)")
            case .success(let message):
                switch message {
                case .string(let text):
                    DispatchQueue.main.async {
                        self?.latestUpdate = text
                        print("Received string: \(text)")
                    }
                case .data(let data):
                    print("Received data: \(data)")
                @unknown default:
                    fatalError()
                }
                self?.receiveMessage() // Listen continuously
            }
        }
    }

    func disconnect() {
        webSocketTask?.cancel(with: .normalClosure, reason: nil)
    }
}
