//
//  DriverDetailViewModelTests.swift
//  ClinicalLabTests
//
//  Created by Vaibhav Rajani on 3/20/24.
//

import Foundation
import XCTest
@testable import ClinicalLab

class DriverDetailViewModelTests: XCTestCase {
    
    var viewModel: DriverDetailViewModel!
    
    override func setUpWithError() throws {
        super.setUp()
        viewModel = DriverDetailViewModel()
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
        super.tearDown()
    }
    
    func testFetchRouteDetailSuccess() {

        let expectation = self.expectation(description: "FetchRouteDetail")
        
        viewModel.fetchRouteDetail(routeNo: 87)

        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 15)
        
        XCTAssertFalse(self.viewModel.routeDetails.isEmpty, "The routeDetails should not be empty on successful fetch.")
    }
}
