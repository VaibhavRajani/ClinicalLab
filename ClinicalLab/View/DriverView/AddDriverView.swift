//
//  AddDriverView.swift
//  ClinicalLab
//
//  Created by Vaibhav Rajani on 2/18/24.
//

import Foundation
import SwiftUI

struct AddDriverView: View {
    @Binding var isPresented: Bool
    @ObservedObject var viewModel: GetDriverViewModel
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var phoneNumber: String = ""
    
    let buttonBackgroundColor = Color.customPink
    let buttonTextColor = Color.white
    
    var body: some View {
        VStack(spacing: 20) {
            Text(Strings.addDriverTitle)
                .font(.headline)
                .foregroundColor(.customPink)
            
            TextField(Strings.firstNamePlaceholder, text: $firstName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .multilineTextAlignment(.center)
            
            TextField(Strings.lastNamePlaceholder, text: $lastName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .multilineTextAlignment(.center)
            
            TextField(Strings.lastNamePlaceholder, text: $phoneNumber)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.phonePad)
                .multilineTextAlignment(.center)
            
            HStack(spacing: 10) {
                Button(Strings.reset) {
                    resetFields()
                }.buttonStyle(AddDriverButtonStyle(backgroundColor: buttonBackgroundColor, textColor: buttonTextColor))
                
                Button(Strings.cancel) {
                    isPresented = false
                }.buttonStyle(AddDriverButtonStyle(backgroundColor: buttonBackgroundColor, textColor: buttonTextColor))
            }
            Button(Strings.addDriverTitle) {
                viewModel.addDriver(firstName: firstName, lastName: lastName, phoneNumber: phoneNumber)
                isPresented = false
            }.buttonStyle(AddDriverButtonStyle(backgroundColor: buttonBackgroundColor, textColor: buttonTextColor))
        }
        .padding()
        .frame(width: 450, height: 400)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 10)
    }
    
    private func resetFields() {
        firstName = ""
        lastName = ""
        phoneNumber = ""
    }
}

struct AddDriverButtonStyle: ButtonStyle {
    var backgroundColor: Color
    var textColor: Color
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding()
            .background(backgroundColor)
            .foregroundColor(textColor)
            .cornerRadius(8)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
    }
}

struct AddDriverView_Previews: PreviewProvider {
    static var previews: some View {
        AddDriverView(isPresented: .constant(true), viewModel: GetDriverViewModel())
    }
}
