//
//  Customer.swift
//  ClinicalLab
//
//  Created by Vaibhav Rajani on 3/28/24.
//

import Foundation

struct Customer: Codable, Identifiable {
    var id: Int { customerId ?? 0 }
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


struct Cust: Codable, Identifiable, Hashable {
    var id: Int { customerId ?? 0 }
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
