//
//  HomeViewModel.swift
//  ClinicalLab
//
//  Created by Vaibhav Rajani on 2/12/24.
//

import SwiftUI
import Foundation
import Combine

class HomeViewModel: ObservableObject {
    @Published var details: [Detail] = []
    @Published var totalSpecimensCollected = 0
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private var cancellables = Set<AnyCancellable>()
    
    func fetchDetailsForAdmin() {
        isLoading = true
        errorMessage = nil
        
        guard let url = URL(string: "https://pclwebapi.azurewebsites.net/api/Admin/GetDetailForAdmin") else {
            self.errorMessage = "Invalid URL"
            return
        }
                
        URLSession.shared.dataTaskPublisher(for: url)
            .receive(on: DispatchQueue.main)
            .tryMap { output in
                guard let response = output.response as? HTTPURLResponse,
                      response.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                let dataString = String(decoding: output.data, as: UTF8.self)
                print("Response Data String: \(dataString)")
                return output.data
            }
            .decode(type: [Detail].self, decoder: JSONDecoder())
            .sink(receiveCompletion: { completion in
                self.isLoading = false
                if case let .failure(error) = completion {
                    self.errorMessage = error.localizedDescription
                    self.insertDummyData()
                }
            }, receiveValue: { fetchedDetails in
                if fetchedDetails.isEmpty {
                    self.insertDummyData()
                } else {
                    self.details = fetchedDetails
                    self.totalSpecimensCollected = fetchedDetails.reduce(0) { $0 + $1.numberOfSpecimens }
                }
                print("Fetched Details: \(fetchedDetails)")
            })
            .store(in: &cancellables)
    }
    
    private func insertDummyData() {
        let dummyDetail = Detail(
            id: 0,
            routeNo: 110,
            customerId: 0,
            status: 0,
            pickUp_Dt: "9:00 AM",
            pickUp_Time: "9:00 AM",
            numberOfSpecimens: 10,
            createdDate: "2024-02-13",
            updatedByDriver: "Dummy Driver"
        )
        self.details = [dummyDetail]
        self.totalSpecimensCollected = dummyDetail.numberOfSpecimens
    }
}
