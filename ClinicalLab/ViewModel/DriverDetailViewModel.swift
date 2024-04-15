//
//  RouteDetailViewModel.swift
//  ClinicalLab
//
//  Created by Vaibhav Rajani on 2/12/24.
//

import Foundation
import Combine

class DriverDetailViewModel: ObservableObject {
    @Published var routeDetails: [RouteDetailResponse] = []
    @Published var driverLocation: DriverLocation?
    private let routeDetailService = RouteDetailService()
    
    func fetchRouteDetail(routeNo: Int) {
        routeDetailService.getRouteDetail(routeNumber: routeNo) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let routeDetails):
//                    print("Fetched route details: \(routeDetails)")
                    
                    self?.routeDetails = routeDetails
//                    print("\(routeDetails)")
                    if let driverId = routeDetails.first?.route.driverId {
                        self?.fetchDriverLocation(driverId: driverId)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func fetchDriverLocation(driverId: Int) {
        routeDetailService.getDriverLocation(driverId: driverId) { [weak self] result in
            DispatchQueue.main.async{
                switch result {
                case.success(let location):
                    self?.driverLocation = location
                case.failure(let error):
                    print("Error fetching driver location: \(error)")
                }
            }
            
        }
    }

}
