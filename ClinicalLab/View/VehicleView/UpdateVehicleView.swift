//
//  updateVehicleView.swift
//  ClinicalLab
//
//  Created by Vaibhav Rajani on 2/20/24.
//

import Foundation
import SwiftUI

struct UpdateVehicleView: View {
    @Binding var isPresented: Bool
    @ObservedObject var viewModel: GetVehicleViewModel
    var vehicle: Vehicle
    
    @State private var manufacturer: String
    @State private var model: String
    @State private var plateNumber: String
    @State private var vehicleId: Int
    
    init(vehicle: Vehicle, isPresented: Binding<Bool>, viewModel: GetVehicleViewModel) {
        self.vehicle = vehicle
        self._isPresented = isPresented
        self.viewModel = viewModel
        _manufacturer = State(initialValue: vehicle.manufacturer ?? "")
        _model = State(initialValue: vehicle.model ?? "")
        _plateNumber = State(initialValue: vehicle.plateNumber ?? "")
        _vehicleId = State(initialValue: vehicle.vehicleId ?? 1)
    }
    
    let buttonBackgroundColor = Color.customPink
    let buttonTextColor = Color.white
    var body: some View {
        ZStack{
  
            VStack {
                Text(Strings.updateVehicleTitle)
                    .font(.headline)
                    .padding(.bottom, 20)
                    .foregroundColor(.customPink)
                
                TextField(Strings.plateNumberPlaceholder, text: $plateNumber)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.bottom, 10)
                    .multilineTextAlignment(.center)
                
                TextField(Strings.vehicleMakePlaceholder, text: $manufacturer)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.bottom, 10)
                    .multilineTextAlignment(.center)

                TextField(Strings.vehicleModelPlaceholder, text: $model)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.phonePad)
                    .multilineTextAlignment(.center)

                HStack(spacing: 10) {
                    Button(action: {
                        resetFields()
                    }) {
                        Text(Strings.resetButtonTitle)
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding()
                            .background(buttonBackgroundColor)
                            .foregroundColor(buttonTextColor)
                    }
                    Button(action: {
                        self.isPresented = false
                    }) {
                        Text(Strings.cancelButtonTitle)
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding()
                            .background(buttonBackgroundColor)
                            .foregroundColor(buttonTextColor)
                    }
                }
                
                Button(action: {
                    viewModel.updateVehicle(vehicle: Vehicle(vehicleId: vehicle.vehicleId, plateNumber: plateNumber, manufacturer: manufacturer, model: model))
                    self.isPresented = false
                }) {
                    Text(Strings.update)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .background(buttonBackgroundColor)
                        .foregroundColor(buttonTextColor)
                }
            }
            .padding()
            .frame(width: 450, height: 400)
            .background(Color.white)
            .cornerRadius(12)
            .shadow(radius: 10)
        }
        
    }
    
    private func resetFields() {
        manufacturer = vehicle.manufacturer ?? ""
        model = vehicle.model ?? ""
        plateNumber = vehicle.plateNumber ?? ""
    }
}


