//
//  GetRouteViewModel.swift
//  ClinicalLab
//
//  Created by Vaibhav Rajani on 2/21/24.
//

import Foundation
import Combine

class GetRouteViewModel: ObservableObject {
    @Published var routeDetails: [RouteDetailResponse] = []
    private let getRouteService = GetRouteService()
    
    func fetchRoutes() {
        getRouteService.getRoute { [weak self] result in
            switch result {
            case .success(let routeDetails):
                self?.routeDetails = routeDetails
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func updateRoute(routeDetail: RouteDetailResponse, newRouteName: String, newVehicleNo: String, newDriverId: Int, newCustomerIDs: String, completion: @escaping (Bool) -> Void) {
        guard let routeNo = routeDetail.route.routeNo else { return }
        
        getRouteService.updateRoute(customerIDs: newCustomerIDs, driverId: newDriverId, routeName: newRouteName, vehicleNo: newVehicleNo, routeNo: routeNo) { result in
            switch result {
            case .success:
                print("Route updated successfully.")
                self.fetchRoutes()
                completion(true)
            case .failure(let error):
                print("Error updating route: \(error.localizedDescription)")
                completion(false)
            }
        }
    }
    
    func addNewRoute(customerIDs: String, driverId: Int, routeName: String, vehicleNo: String) {
        getRouteService.addRoute(customerIDs: customerIDs, driverId: driverId, routeName: routeName, vehicleNo: vehicleNo) { result in
            switch result {
            case .success(let successMessage):
                print("Route added successfully: \(successMessage)")
                self.fetchRoutes()
            case .failure(let error):
                print("Failed to add route: \(error.localizedDescription)")
            }
        }
    }
    
    func deleteRoute(routeNo: Int) {
        getRouteService.deleteRoute(routeNo: routeNo) { [weak self] result in
            switch result {
            case .success:
                print("Route deleted successfully.")
                self?.fetchRoutes()
            case .failure(let error):
                print("Error deleting Route: \(error.localizedDescription)")
            }
        }
    }
}
