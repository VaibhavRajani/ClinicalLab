//
//  GetVehicleViewModel.swift
//  ClinicalLab
//
//  Created by Vaibhav Rajani on 2/20/24.
//

import Foundation

class GetVehicleViewModel: ObservableObject {
    @Published var vehicles: [Vehicle] = []
    private var getVehicleService = GetVehicleService()

    func fetchVehicles() {
        getVehicleService.getVehicles { [weak self] result in
            switch result {
            case .success(let vehicles):
                self?.vehicles = vehicles
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func addVehicle(manufacturer: String, model: String, plateNumber: String, vehicleId: Int) {
        getVehicleService.addVehicle(manufacturer: manufacturer, model: model, plateNumber: plateNumber, vehicleId: vehicleId) { [weak self] result in
            switch result {
            case .success(_):
                print("Vehicle added successfully.")
                self?.fetchVehicles()
            case .failure(let error):
                print("Error adding vehicle: \(error.localizedDescription)")
            }
        }
    }
    
    func updateVehicle(vehicle: Vehicle){
        getVehicleService.updateVehicle(manufacturer: vehicle.manufacturer ?? "", model: vehicle.model ?? "", plateNumber: vehicle.plateNumber ?? "", vehicleId: vehicle.vehicleId ?? 1) { result in
            switch result {
            case .success(_):
                print("Vehicle Updated Successfully.")
                self.fetchVehicles()
            case .failure(let error):
                print("Error updating vehicle: \(error.localizedDescription)")
            }
        }
    }
    
    func deleteVehicle(vehicleId: Int) {
        getVehicleService.deleteVehicle(vehicleId: vehicleId) { [weak self] result in
            switch result {
            case .success:
                print("Vehicle deleted successfully.")
                self?.fetchVehicles()
            case .failure(let error):
                print("Error deleting vehicle: \(error.localizedDescription)")
            }
        }
    }
}
