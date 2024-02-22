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
    @ObservedObject var viewModel = GetRouteViewModel()
    var routeDetail: RouteDetailResponse
    @State private var newRouteName: String = ""
    @State private var newVehicleNo: String = ""
    @State private var newDriverId: String = ""
    @State private var newCustomerIDs: String = ""
    @State private var additionalCustomerIDs: [String] = []

    let buttonBackgroundColor = Color.customPink
    let buttonTextColor = Color.white
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Add Route")
                .font(.title)
                .foregroundColor(.customPink)
            
            HStack (spacing: 7){
                Text("\(routeDetail.route.routeNo ?? 0)")                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .multilineTextAlignment(.center)
                    .multilineTextAlignment(.center)
                TextField("Route Name", text: $newRouteName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .multilineTextAlignment(.center)
            }
            
            HStack (spacing: 7){
                TextField("Driver Id", text: $newDriverId)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .multilineTextAlignment(.center)
                TextField("Vehicle Number", text: $newVehicleNo)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .multilineTextAlignment(.center)
            }
            
            ForEach(routeDetail.customer) { customer in
                HStack {
                    Text(customer.customerName ?? "Unknown")
                    Spacer()
                    Text(customer.streetAddress ?? "")
                }
            }

            HStack {
                TextField("New Customer ID", text: $newCustomerIDs)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button(action: {
                    additionalCustomerIDs.append(newCustomerIDs)
                    newCustomerIDs = "" // Clear the field after adding
                }) {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .frame(width: 20, height: 20)
                }
            }

            // Show new customer IDs to be added
            ForEach(additionalCustomerIDs, id: \.self) { id in
                Text("New ID: \(id)")
            }
            
            HStack(spacing: 10) {
                Button("Reset") {
                    resetFields()
                }.buttonStyle(AddDriverButtonStyle(backgroundColor: buttonBackgroundColor, textColor: buttonTextColor))
                
                Button("Update") {
                    if let driverIdInt = Int(newDriverId) {
                        // Combine the existing customer IDs with additional ones
                        let combinedCustomerIDs = (routeDetail.customer.map { "\($0.customerId ?? 0)" } + additionalCustomerIDs).joined(separator: ",")
                        
                        viewModel.updateRoute(routeDetail: routeDetail, newRouteName: newRouteName, newVehicleNo: newVehicleNo, newDriverId: driverIdInt, newCustomerIDs: combinedCustomerIDs) { success in
                            if success {
                                print("Route updated successfully")
                            } else {
                                print("Failed to update route")
                            }
                            isPresented = false
                        }
                    } else {
                        print("Driver ID is not valid.")
                    }
                }.buttonStyle(AddDriverButtonStyle(backgroundColor: buttonBackgroundColor, textColor: buttonTextColor))

            }
        }
        .padding()
        .frame(width: 700, height: 700)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 10)
    }
    private func resetFields() {

    }
}
