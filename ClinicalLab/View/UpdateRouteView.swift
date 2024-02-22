//
//  UpdateRouteView.swift
//  ClinicalLab
//
//  Created by Vaibhav Rajani on 2/21/24.
//

import Foundation
import SwiftUI

struct UpdateRouteView: View {
    @Binding var isPresented: Bool
    @ObservedObject var viewModel: GetRouteViewModel
    var routeDetail: RouteDetailResponse
    
    @State private var newRouteName: String = ""
    @State private var newVehicleNo: String = ""
    @State private var newDriverId: String = ""
    @State private var newCustomerIDs: String = ""
    
    var body: some View {
        VStack {
            TextField("Route Name", text: $newRouteName)
            TextField("Vehicle No", text: $newVehicleNo)
            TextField("Driver Id", text: $newDriverId)
            TextField("Customer IDs", text: $newCustomerIDs)
            Button("Update Route") {
                guard let driverId = Int(newDriverId) else { return }
                viewModel.updateRoute(routeDetail: routeDetail, newRouteName: newRouteName, newVehicleNo: newVehicleNo, newDriverId: driverId, newCustomerIDs: newCustomerIDs) { success in
                    if success {
                        isPresented = false
                    } else {
                        print("Error")
                    }
                }
            }
        }
    }
}
