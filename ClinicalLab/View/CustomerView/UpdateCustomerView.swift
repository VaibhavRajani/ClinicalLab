//
//  UpdateCustomerView.swift
//  ClinicalLab
//
//  Created by Vaibhav Rajani on 2/19/24.
//

import Foundation
import SwiftUI

struct UpdateCustomerView: View {
    @Binding var isPresented: Bool
    @ObservedObject var viewModel: GetCustomerViewModel
    var customer: Cust
    @State private var customerName: String = ""
    @State private var streetAddress: String = ""
    @State private var city: String = ""
    @State private var state: String = ""
    @State private var zip: String = ""
    @State private var custLat: Double = 0.0
    @State private var custLong: Double = 0.0
    @State private var pickupTime = Date()
    
    init(customer: Cust, isPresented: Binding<Bool>, viewModel: GetCustomerViewModel) {
        self.customer = customer
        self._isPresented = isPresented
        self.viewModel = viewModel
        _customerName = State(initialValue: customer.customerName ?? "")
        _streetAddress = State(initialValue: customer.streetAddress ?? "")
        _city = State(initialValue: customer.city ?? "")
        _state = State(initialValue: customer.state ?? "")
        _zip = State(initialValue: customer.zip ?? "")
        _custLat = State(initialValue: customer.cust_Lat ?? 12.12)
        _custLong = State(initialValue: customer.cust_Log ?? 12.12)
        if let time = DateFormatter.timeFormatter.date(from: customer.pickUpTime ?? "") {
            _pickupTime = State(initialValue: time)
        } else {
            _pickupTime = State(initialValue: Date())
        }

    }
    let buttonBackgroundColor = Color.customPink
    let buttonTextColor = Color.white
    var body: some View {
        ZStack{
            VStack(spacing: 20) {
                Text("Update Customer")
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
                Button("Update") {
                    viewModel.updateCustomer(customer: Cust(
                        customerId: customer.customerId,
                        customerName: customerName,
                        streetAddress: streetAddress,
                        city: city,
                        state: state,
                        zip: zip,
                        collectionStatus: customer.collectionStatus,
                        specimensCount: customer.specimensCount,
                        pickUpTime: DateFormatter.timeFormatter.string(from: pickupTime), 
                        isSelected: customer.isSelected,
                        cust_Lat: custLat,
                        cust_Log: custLong
                    ))
                    self.isPresented = false
                }.buttonStyle(AddDriverButtonStyle(backgroundColor: buttonBackgroundColor, textColor: buttonTextColor))

            }
            .padding()
            .frame(width: 700, height: 700)
            .background(Color.white)
            .cornerRadius(12)
            .shadow(radius: 10)
            }
        
    }
    
    private func resetFields() {
        customerName = customer.customerName!
        streetAddress = customer.streetAddress!
        city = customer.city!
        state = customer.state!
        zip = customer.zip!
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        
        if let date = dateFormatter.date(from: customer.pickUpTime!) {
            pickupTime = date
        } else {
            pickupTime = Date()
        }
    }
}

extension DateFormatter {
    static let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter
    }()
}


#Preview{
    UpdateCustomerView(customer: Cust(customerId: 1, customerName: "Vaibhav Rajani", streetAddress: "asdasdsa", city: "sadsad", state: "dasdsad", zip: "asdasda", collectionStatus: "Not", specimensCount: 0, pickUpTime: "dsasad", isSelected: true, cust_Lat: 12.99, cust_Log: 12.90), isPresented: .constant(true), viewModel: GetCustomerViewModel())
}
