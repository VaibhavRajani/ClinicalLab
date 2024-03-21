//
//  GetRouteViewModelTests.swift
//  ClinicalLabTests
//
//  Created by Vaibhav Rajani on 3/20/24.
//

import Foundation
import XCTest
@testable import ClinicalLab

class GetRouteViewModelTests: XCTestCase {
    
    var viewModel: GetRouteViewModel!
    
    override func setUpWithError() throws {
        super.setUp()
        viewModel = GetRouteViewModel()
    }

    override func tearDownWithError() throws {
        viewModel = nil
        super.tearDown()
    }
    
    func testFetchRoutes() {
        let expectation = self.expectation(description: "FetchRoutes")
        
        viewModel.fetchRoutes()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5)
        
        XCTAssertFalse(self.viewModel.routeDetails.isEmpty, "The routeDetails should not be empty after fetching.")
    }
    
    func testAddNewRoute() {
        let expectation = self.expectation(description: "AddNewRoute")
        
        let initialCount = viewModel.routeDetails.count
        
        viewModel.addNewRoute(customerIDs: "1,2", driverId: 2, routeName: "Test Route 2", vehicleNo: "AB1234")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5)
        
        XCTAssertTrue(self.viewModel.routeDetails.count > initialCount, "A new route should have been added.")
    }
}
