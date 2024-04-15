//
//  AddVehicleView.swift
//  ClinicalLab
//
//  Created by Vaibhav Rajani on 2/20/24.
//

import Foundation
import SwiftUI

struct AddVehicleView: View {
    @Binding var isPresented: Bool
    @ObservedObject var viewModel: GetVehicleViewModel
    @State private var plateNumber: String = ""
    @State private var manufacturer: String = ""
    @State private var model: String = ""
    @State private var vehicleId: Int = 0

    let buttonBackgroundColor = Color.customPink
    let buttonTextColor = Color.white
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Add Vehicle")
                .font(.title)
                .foregroundColor(.customPink)
            
            TextField("Plate Number", text: $plateNumber)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .multilineTextAlignment(.center)
            
//            Picker("Select Vehicle", selection: $selectedVehicleId) {
//                            ForEach(viewModel.vehicles) { vehicle in
//                                Text(vehicle.plateNumber ?? "Unknown").tag(vehicle.vehicleId as Int?)
//                            }
//                        }
//                        .pickerStyle(MenuPickerStyle())
            
            
            TextField("Vehicle Make", text: $manufacturer)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .multilineTextAlignment(.center)
            
            TextField("Vehicle Model", text: $model)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .multilineTextAlignment(.center)
            
            HStack(spacing: 10) {
                Button("Reset") {
                    resetFields()
                }.buttonStyle(AddDriverButtonStyle(backgroundColor: buttonBackgroundColor, textColor: buttonTextColor))
                
                Button("Cancel") {
                    isPresented = false
                }.buttonStyle(AddDriverButtonStyle(backgroundColor: buttonBackgroundColor, textColor: buttonTextColor))
            }
            Button("Add") {
                viewModel.addVehicle(manufacturer: manufacturer, model: model, plateNumber: plateNumber, vehicleId: vehicleId)
                isPresented = false
            }.buttonStyle(AddDriverButtonStyle(backgroundColor: buttonBackgroundColor, textColor: buttonTextColor))
        }
        .onAppear {
                    viewModel.fetchVehicles() 
                }
        .padding()
        .frame(width: 450, height: 400)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 10)
    }
    
    private func resetFields() {
        model = ""
        manufacturer = ""
        plateNumber = ""
        vehicleId = 1
    }
}
