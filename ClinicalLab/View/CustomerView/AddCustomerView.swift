//
//  AddCustomerView.swift
//  ClinicalLab
//
//  Created by Vaibhav Rajani on 2/19/24.
//

import Foundation
import SwiftUI

struct AddCustomerView: View {
    @Binding var isPresented: Bool
    @ObservedObject var viewModel: GetCustomerViewModel
    @State private var customerName: String = ""
    @State private var streetAddress: String = ""
    @State private var city: String = ""
    @State private var state: String = ""
    @State private var zip: String = ""
    @State private var custLat: Double = 0.0
    @State private var custLong: Double = 0.0
    @State private var pickupTime = Date()
    
    let buttonBackgroundColor = Color.customPink
    let buttonTextColor = Color.white
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Add Customer")
                .font(.title)
                .foregroundColor(.customPink)
            
            TextField("CustomerName", text: $customerName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .multilineTextAlignment(.center)
            
            TextField("Address", text: $streetAddress)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .multilineTextAlignment(.center)
            
            HStack (spacing: 7){
                TextField("City", text: $city)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .multilineTextAlignment(.center)
                TextField("State", text: $state)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .multilineTextAlignment(.center)
                TextField("Zip", text: $zip)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .multilineTextAlignment(.center)
            }
            
            Text("Standard Pickup Time")
                .font(.title2)
                .foregroundColor(.customPink)
            
            DatePicker(
                "",
                selection: $pickupTime,
                displayedComponents: .hourAndMinute
            )
            .frame(alignment: .center)
            .labelsHidden()
            .datePickerStyle(WheelDatePickerStyle())
            
            HStack(spacing: 10) {
                Button("Reset") {
                    resetFields()
                }.buttonStyle(AddDriverButtonStyle(backgroundColor: buttonBackgroundColor, textColor: buttonTextColor))
                
                Button("Cancel") {
                    isPresented = false
                }.buttonStyle(AddDriverButtonStyle(backgroundColor: buttonBackgroundColor, textColor: buttonTextColor))
            }
            Button("Add") {
                viewModel.addCustomer(customerName: customerName, streetAddress: streetAddress, city: city, state: state, zip: zip, custLat: custLat, custLong: custLong, pickupTime: pickupTime)
                isPresented = false
            }.buttonStyle(AddDriverButtonStyle(backgroundColor: buttonBackgroundColor, textColor: buttonTextColor))
        }
        .padding()
        .frame(width: 700, height: 700)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 10)
    }
    
    private func resetFields() {
        customerName = ""
        streetAddress = ""
        city = ""
        state = ""
        zip = ""
    }
}

#Preview {
    AddCustomerView(isPresented: .constant(true), viewModel: GetCustomerViewModel())
}

