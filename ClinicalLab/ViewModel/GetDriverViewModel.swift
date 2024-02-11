//
//  GetDriverViewModel.swift
//  ClinicalLab
//
//  Created by Vaibhav Rajani on 2/17/24.
//

import Foundation

class GetDriverViewModel: ObservableObject {
    @Published var drivers: [Driver] = []
    private var getDriverService = GetDriverService()
    
    func fetchDrivers() {
        getDriverService.getDrivers { [weak self] result in
            switch result {
            case .success(let drivers):
                self?.drivers = drivers
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func updateDriver(driver: Driver) {
        getDriverService.updateDriver(driverId: driver.driverId, firstName: driver.firstName ?? "", lastName: driver.lastName ?? "", phoneNumber: driver.phoneNumber) { result in
            switch result {
            case .success(_):
                print("Driver updated successfully.")
                self.fetchDrivers()
            case .failure(let error):
                print("Error updating driver: \(error.localizedDescription)")
            }
        }
    }
    
    func addDriver(firstName: String, lastName: String, phoneNumber: String) {
        getDriverService.addDriver(firstName: firstName, lastName: lastName, phoneNumber: phoneNumber) { [weak self] result in
            switch result {
            case .success(_):
                print("Driver added successfully.")
                self?.fetchDrivers()
            case .failure(let error):
                print("Error adding driver: \(error.localizedDescription)")
            }
        }
    }
    
    func deleteDriver(driverId: Int) {
        getDriverService.deleteDriver(driverId: driverId) { [weak self] result in
            switch result {
            case .success:
                print("Driver deleted successfully.")
                self?.fetchDrivers()
            case .failure(let error):
                print("Error deleting driver: \(error.localizedDescription)")
            }
        }
    }
}
