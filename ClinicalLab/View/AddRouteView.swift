//
//  AddRouteView.swift
//  ClinicalLab
//
//  Created by Vaibhav Rajani on 2/21/24.
//

import Foundation
import SwiftUI

struct AddRouteView: View {
    @Binding var isPresented: Bool
    @ObservedObject var viewModel: GetRouteViewModel
    @State private var customerIds: String = ""
    @State private var driverId: String = ""
    @State private var routeName: String = ""
    @State private var vehicleNo: String = ""
    
    let buttonBackgroundColor = Color.customPink
    let buttonTextColor = Color.white
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Add Route")
                .font(.title)
                .foregroundColor(.customPink)
            
            HStack (spacing: 7){
                TextField("Customer Id(s) (separate with commas)", text: $customerIds)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .multilineTextAlignment(.center)
                    .multilineTextAlignment(.center)
                TextField("Route Name", text: $routeName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .multilineTextAlignment(.center)
            }            
            
            HStack (spacing: 7){
                TextField("Driver Id", text: $driverId)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .multilineTextAlignment(.center)
                TextField("Vehicle Number", text: $vehicleNo)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .multilineTextAlignment(.center)
            }
            
            HStack(spacing: 10) {
                Button("Reset") {
                    resetFields()
                }.buttonStyle(AddDriverButtonStyle(backgroundColor: buttonBackgroundColor, textColor: buttonTextColor))
                
                Button("Add") {
                    if let driverIdInt = Int(driverId) {
                        viewModel.addNewRoute(customerIDs: customerIds, driverId: driverIdInt, routeName: routeName, vehicleNo: vehicleNo)
                    }
                    isPresented = false
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
        customerIds = ""
        driverId = ""
        routeName = ""
        vehicleNo = ""
    }
}

#Preview {
    AddRouteView(isPresented: .constant(true), viewModel: GetRouteViewModel())
}
