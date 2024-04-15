//
//  Driver.swift
//  ClinicalLab
//
//  Created by Vaibhav Rajani on 3/28/24.
//

import Foundation

struct DriverLocation: Codable {
    let lat: Double
    let log: Double
    let geofence: Bool
    
    enum CodingKeys: String, CodingKey {
        case lat = "Lat"
        case log = "Log"
        case geofence = "Geofence"
    }
}

struct Driver: Codable, Identifiable {
    var id: Int { driverId }
    let driverId: Int
    let driverName: String
    let firstName: String?
    let lastName: String?
    let phoneNumber: String
    
    enum CodingKeys: String, CodingKey{
        case driverId = "DriverId"
        case driverName = "DriverName"
        case firstName = "FirstName"
        case lastName = "LastName"
        case phoneNumber = "PhoneNumber"
    }
}

struct DeleteDriverResponse: Codable {
    let result: String
}
