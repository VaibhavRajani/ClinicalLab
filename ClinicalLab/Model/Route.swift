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



