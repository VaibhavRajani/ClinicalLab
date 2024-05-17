//
//  AdminPollingViewModel.swift
//  ClinicalLab
//
//  Created by Vaibhav Rajani on 5/10/24.
//

import Foundation

class AdminPollingViewModel: ObservableObject {
    @Published var details: [Detail] = []
    var timer: Timer?

    func startPolling() {
        timer = Timer.scheduledTimer(withTimeInterval: 30.0, repeats: true) { [weak self] _ in
            self?.fetchDetails()
        }
    }

    func stopPolling() {
        timer?.invalidate()
        timer = nil
    }

    func fetchDetails() {

    }
}
