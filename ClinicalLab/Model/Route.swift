//
//  Route.swift
//  ClinicalLab
//
//  Created by Vaibhav Rajani on 2/12/24.
//

import Foundation

struct RouteDetailResponse: Codable {
    var route: Route
    var customer: [Customer]
    enum CodingKeys: String, CodingKey {
        case route = "Route"
        case customer = "Customer"
    }}

struct Route: Codable {
    var routeNo: Int?
    var routeName: String?
    var driverId: Int?
    var driverName: String?
    var vehicleNo: String?
    var vehicleId: Int?

    enum CodingKeys: String, CodingKey {
        case routeNo = "RouteNo"
        case routeName = "RouteName"
        case driverId = "DriverId"
        case driverName = "DriverName"
        case vehicleNo = "VehicleNo"
        case vehicleId = "VehicleId"
    }
}

struct Customer: Codable {
    let customerId: Int?
    let customerName: String?
    let streetAddress: String?
    var city: String?
    let state: String?
    let zip: String?
    let pickUpTime: String?
    let specimensCollected: Int?
    let collectionStatus: String?
    let isSelected: Bool?
    let cust_Lat: Double?
    let cust_Log: Double?
    
    enum CodingKeys: String, CodingKey {
        case customerId = "CustomerId"
        case customerName = "CustomerName"
        case streetAddress = "StreetAddress"
        case city = "City"
        case state = "State"
        case zip = "Zip"
        case pickUpTime = "PickUpTime"
        case specimensCollected = "SpecimensCollected"
        case collectionStatus = "CollectionStatus"
        case isSelected = "IsSelected"
        case cust_Lat = "Cust_Lat"
        case cust_Log = "Cust_Log"
    }
}

struct Cust: Codable {
    let customerId: Int?
    let customerName: String?
    let streetAddress: String?
    var city: String?
    let state: String?
    let zip: String?
    let collectionStatus: String?
    let specimensCount: Int?
    let pickUpTime: String?
    let isSelected: Bool?
    let cust_Lat: Double?
    let cust_Log: Double?
    
    enum CodingKeys: String, CodingKey {
        case customerId = "CustomerId"
        case customerName = "CustomerName"
        case streetAddress = "StreetAddress"
        case city = "City"
        case state = "State"
        case zip = "Zip"
        case collectionStatus = "CollectionStatus"
        case specimensCount = "SpecimenCount"
        case pickUpTime = "PickUpTime"
        case isSelected = "IsSelected"
        case cust_Lat = "Cust_Lat"
        case cust_Log = "Cust_Log"
    }
}

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

struct Driver: Codable {
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

struct Vehicle: Codable {
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
