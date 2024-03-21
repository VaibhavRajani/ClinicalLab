//
//  GetCustomerViewModelTests.swift
//  ClinicalLabTests
//
//  Created by Vaibhav Rajani on 3/20/24.
//

import Foundation
import XCTest
@testable import ClinicalLab

class GetCustomerViewModelTests: XCTestCase {
    
    var viewModel: GetCustomerViewModel!
    
    override func setUpWithError() throws {
        viewModel = GetCustomerViewModel()
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }

    func testFetchCustomersSuccess() {
        let expectation = self.expectation(description: "FetchCustomers")
        
        viewModel.fetchCustomers()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertFalse(self.viewModel.customers.isEmpty, "Customers should not be empty after fetch")
    }

    func testAddCustomer() {
        let expectation = self.expectation(description: "AddCustomer")

        let testCustomerName = "TestCustomer1_\(UUID().uuidString)"
        let testStreetAddress = "1232 Test Street"
        let testCity = "Test1 City"
        let testState = "Test11 State"
        let testZip = "00010"
        let testCustLat: Double = 0.0
        let testCustLong: Double = 0.0
        let testPickupTime = Date()

        viewModel.addCustomer(customerName: testCustomerName, streetAddress: testStreetAddress, city: testCity, state: testState, zip: testZip, custLat: testCustLat, custLong: testCustLong, pickupTime: testPickupTime)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)

    }
}
