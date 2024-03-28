//
//  Vehicle.swift
//  ClinicalLab
//
//  Created by Vaibhav Rajani on 3/28/24.
//

import Foundation

struct Vehicle: Codable, Identifiable {
    var id: Int { vehicleId ?? 0 }
    let vehicleId: Int?
    let plateNumber: String?
    let manufacturer: String?
    let model: String?
    
    enum CodingKeys: String, CodingKey{
        case vehicleId = "VehicleId"
        case plateNumber = "PlateNumber"
        case manufacturer = "Manufacturer"
        case model = "Model"
    }
}
