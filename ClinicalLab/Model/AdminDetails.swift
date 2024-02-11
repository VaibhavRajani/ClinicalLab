//
//  AdminDetails.swift
//  ClinicalLab
//
//  Created by Vaibhav Rajani on 2/12/24.
//

import Foundation

struct Detail: Decodable, Identifiable {
    let id: Int
    let routeNo: Int
    let customerId: Int
    let status: Int
    let pickUp_Dt: String
    let pickUp_Time: String
    let numberOfSpecimens: Int
    let createdDate: String
    let updatedByDriver: String

    enum CodingKeys: String, CodingKey {
        case id = "TranId"
        case routeNo = "RouteNo"
        case customerId = "CustomerId"
        case status = "Status"
        case pickUp_Dt = "PickUp_Dt"
        case pickUp_Time = "PickUp_Time"
        case numberOfSpecimens = "NumberOfSpecimens"
        case createdDate = "CreatedDate"
        case updatedByDriver = "UpdatedByDriver"
    }
}
