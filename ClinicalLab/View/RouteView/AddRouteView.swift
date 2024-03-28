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
    @ObservedObject var customerViewModel = GetCustomerViewModel()
    @ObservedObject var vehicleViewModel = GetVehicleViewModel()
    @ObservedObject var driverViewModel = GetDriverViewModel()
    @State private var driverInput: String = ""
    @State private var showingDriverSelection = false
    @State private var customerInput: String = ""
    @State private var selectedCustomerIDs: [String] = []
    @State private var selectedDriverId: Int?
    
    @State private var driverId: String = ""
    @State private var routeName: String = ""
    @State private var vehicleInput: String = ""
    @State private var selectedVehicle: Vehicle?
    @State private var showingVehicleSelection = false
    
    let buttonBackgroundColor = Color.customPink
    let buttonTextColor = Color.white
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Add Route")
                .font(.title)
                .foregroundColor(.customPink)
            
            TextField("Type customer ID", text: $customerInput, onCommit: {
                appendCurrentInput()
            })
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .onChange(of: customerInput) { newValue in
                if newValue.last == "," {
                    appendCurrentInput()
                }
            }
            
            if !customerInput.isEmpty && customerInput.last != "," {
                ScrollView {
                    VStack(alignment: .leading) {
                        ForEach(filteredCustomers(), id: \.self) { customer in
                            Text("\(customer.customerName ?? "Unknown") (\(customer.customerId ?? 0))")
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                                .onTapGesture {
                                    addCustomerID(customer.customerId ?? 0)
                                }
                        }
                    }
                }
                .frame(maxHeight: 150)
            }
            
            if !selectedCustomerIDs.isEmpty {
                Text("Selected IDs: \(selectedCustomerIDs.joined(separator: ", "))")
                    .padding()
            }
            
            TextField("Route Name", text: $routeName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            TextField("Type vehicle number", text: $vehicleInput)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .onTapGesture {
                    showingVehicleSelection = true
                }
            
            if showingVehicleSelection && !filteredVehicles().isEmpty {
                ScrollView(.vertical, showsIndicators: true) {
                    VStack(alignment: .leading) {
                        ForEach(filteredVehicles()) { vehicle in
                            Text(vehicle.plateNumber ?? "Unknown")
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .onTapGesture {
                                    selectVehicle(vehicle)
                                }
                        }
                    }
                }
                .frame(maxHeight: 150)
            }
            
            TextField("Type driver name or ID", text: $driverInput)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .onTapGesture {
                    showingDriverSelection = true
                }
            
            if !driverInput.isEmpty {
                ScrollView(.vertical, showsIndicators: true) {
                    VStack(alignment: .leading) {
                        ForEach(filteredDrivers()) { driver in
                            Text("\(driver.driverName) (\(driver.driverId))")
                                .onTapGesture {
                                    self.selectedDriverId = driver.driverId
                                    self.driverInput = "\(driver.driverName) (\(driver.driverId))"
                                }
                        }
                    }
                }.frame(maxHeight: 150)
            }
            
            
            
            Button("Add Route") {
                let customerIDsString = selectedCustomerIDs.joined(separator: ",")
                if let driverIdInt = selectedDriverId {
                    print(driverIdInt)
                    viewModel.addNewRoute(customerIDs: customerIDsString, driverId: driverIdInt, routeName: routeName, vehicleNo: vehicleInput)
                }
                print("Adding with customer IDs: \(customerIDsString)")
                resetFields()
                isPresented = false
            }
            .buttonStyle(AddDriverButtonStyle(backgroundColor: buttonBackgroundColor, textColor: buttonTextColor))
            
        }
        .onAppear {
            customerViewModel.fetchCustomers()
            vehicleViewModel.fetchVehicles()
            driverViewModel.fetchDrivers()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 10)
    }
    
    private func filteredDrivers() -> [Driver] {
        guard !driverInput.isEmpty else { return [] }
        return driverViewModel.drivers.filter { $0.driverName.lowercased().contains(driverInput.lowercased()) || "\($0.driverId)".contains(driverInput) }
    }
    
    private func filteredVehicles() -> [Vehicle] {
        guard !vehicleInput.isEmpty else { return vehicleViewModel.vehicles }
        return vehicleViewModel.vehicles.filter { $0.plateNumber?.lowercased().contains(vehicleInput.lowercased()) ?? false }
    }
    
    private func selectVehicle(_ vehicle: Vehicle) {
        self.selectedVehicle = vehicle
        self.vehicleInput = vehicle.plateNumber ?? ""
        self.showingVehicleSelection = false
    }
    
    private func filteredCustomers() -> [Cust] {
        let lowercasedInput = customerInput.lowercased()
        return customerViewModel.customers.filter {
            $0.customerName?.lowercased().contains(lowercasedInput) ?? false ||
            "\($0.customerId ?? 0)".contains(lowercasedInput)
        }
    }
    
    private func addCustomerID(_ id: Int) {
        selectedCustomerIDs.append(String(id))
        customerInput = ""
    }
    
    private func appendCurrentInput() {
        let trimmedInput = customerInput.trimmingCharacters(in: .whitespacesAndNewlines)
        if !trimmedInput.isEmpty, let _ = Int(trimmedInput) {
            selectedCustomerIDs.append(trimmedInput)
            customerInput = ""
        }
    }
    private func resetFields() {
        customerInput = ""
        selectedCustomerIDs.removeAll()
        driverId = ""
        routeName = ""
        vehicleInput = ""
    }
}

#if DEBUG
struct AddRouteView_Previews: PreviewProvider {
    static var previews: some View {
        AddRouteView(
            isPresented: .constant(true),
            viewModel: GetRouteViewModel(),
            customerViewModel: GetCustomerViewModel(),
            vehicleViewModel: GetVehicleViewModel(),
            driverViewModel: GetDriverViewModel()
        )
    }
}
#endif
