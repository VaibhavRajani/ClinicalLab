//
//  UpdateDriverView.swift
//  ClinicalLab
//
//  Created by Vaibhav Rajani on 2/17/24.
//

import Foundation
import SwiftUI

struct UpdateDriverView: View {
    @Binding var isPresented: Bool
    @ObservedObject var viewModel: GetDriverViewModel
    var driver: Driver
    
    @State private var firstName: String
    @State private var lastName: String
    @State private var phoneNumber: String
    
    init(driver: Driver, isPresented: Binding<Bool>, viewModel: GetDriverViewModel) {
        self.driver = driver
        self._isPresented = isPresented
        self.viewModel = viewModel
        
        let names = driver.driverName.split(separator: " ").map(String.init)
        _firstName = State(initialValue: names.first ?? "")
        _lastName = State(initialValue: names.count > 1 ? names.last ?? "" : "")
        _phoneNumber = State(initialValue: driver.phoneNumber)
    }
    let buttonBackgroundColor = Color.customPink
    let buttonTextColor = Color.white
    var body: some View {
        ZStack{
  
            VStack {
                Text(Strings.updateDriverTitle)
                    .font(.headline)
                    .padding(.bottom, 20)
                    .foregroundColor(.customPink)
                
                TextField(Strings.firstNamePlaceholder, text: $firstName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.bottom, 10)
                    .multilineTextAlignment(.center)
                
                TextField(Strings.lastNamePlaceholder, text: $lastName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.bottom, 10)
                    .multilineTextAlignment(.center)

                TextField(Strings.phoneNumberPlaceholder, text: $phoneNumber)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.phonePad)
                    .multilineTextAlignment(.center)

                HStack(spacing: 10) {
                    Button(action: {
                        resetFields()
                    }) {
                        Text(Strings.reset)
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding()
                            .background(buttonBackgroundColor)
                            .foregroundColor(buttonTextColor)
                    }
                    Button(action: {
                        self.isPresented = false
                    }) {
                        Text(Strings.cancel)
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding()
                            .background(buttonBackgroundColor)
                            .foregroundColor(buttonTextColor)
                    }
                }
                
                Button(action: {
                    viewModel.updateDriver(driver: Driver(driverId: driver.driverId, driverName: "\(firstName) \(lastName)", firstName: firstName, lastName: lastName, phoneNumber: phoneNumber))
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
        let names = driver.driverName.split(separator: " ").map(String.init)
        firstName = names.first ?? ""
        lastName = names.count > 1 ? names.last ?? "" : ""
        phoneNumber = driver.phoneNumber
    }
}

#if DEBUG
struct UpdateDriverView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateDriverView(driver: Driver(driverId: 1, driverName: "John Doe", firstName: "John", lastName: "Doe", phoneNumber: "1234567890"), isPresented: .constant(true), viewModel: GetDriverViewModel())
    }
}
#endif
