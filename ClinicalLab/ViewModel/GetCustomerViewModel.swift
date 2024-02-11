//
//  GetCustomerViewModel.swift
//  ClinicalLab
//
//  Created by Vaibhav Rajani on 2/18/24.
//

import Foundation

class GetCustomerViewModel: ObservableObject {
    @Published var customers: [Cust] = []
    private var getCustomerService = GetCustomerService()
    
    func fetchCustomers() {
        getCustomerService.getCustomers { [weak self] result in
            switch result {
            case .success(let customers):
                self?.customers = customers
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func updateCustomer(customer: Cust){
        getCustomerService.updateCustomer(city: customer.city ?? "", custLat: customer.cust_Lat ?? 0.0, custLong: customer.cust_Log ?? 0.0, customerName: customer.customerName ?? "", pickupTime: customer.pickUpTime ?? "", state: customer.state ?? "", streetAddress: customer.streetAddress ?? "", zip: customer.zip ?? "", customerId: customer.customerId!) { result in
            switch result {
            case .success(_):
                print("Customer updated successfully.")
                self.fetchCustomers()
            case .failure(let error):
                print("Error updating customer: \(error.localizedDescription)")
            }
        }
    }
    
    func addCustomer(customerName: String, streetAddress: String, city: String, state: String, zip: String, custLat: Double, custLong: Double, pickupTime: Date) {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        let pickupTimeString = formatter.string(from: pickupTime)

        getCustomerService.addCustomer(customerName: customerName, streetAddress: streetAddress, city: city, state: state, zip: zip, custLat: custLat, custLong: custLong, pickupTime: pickupTimeString) { result in
            switch result {
            case .success:
                print("Customer added successfully.")
                self.fetchCustomers()
            case .failure(let error):
                print("Error adding customer: \(error.localizedDescription)")
            }
        }
    }
    
    func deleteCustomer(customerId: Int) {
        getCustomerService.deleteCustomer(customerId: customerId) { [weak self] result in
            switch result {
            case .success:
                print("Customer deleted successfully.")
                self?.fetchCustomers()
            case.failure(let error):
                print("Error deleting Customer: \(error.localizedDescription)")
            }
        }
    }
}
