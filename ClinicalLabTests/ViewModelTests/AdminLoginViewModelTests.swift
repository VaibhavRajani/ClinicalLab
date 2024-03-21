//
//  AdminLoginViewModelTests.swift
//  ClinicalLabTests
//
//  Created by Vaibhav Rajani on 3/20/24.
//

import Foundation
import XCTest
@testable import ClinicalLab

class AdminLoginViewModelTests: XCTestCase {

    var viewModel: AdminLoginViewModel!
    
    override func setUpWithError() throws {
        viewModel = AdminLoginViewModel()
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }

    func testLoginInitiatesIsLoggingIn() {
        let expected = true
        
        viewModel.login()
        
        XCTAssertEqual(viewModel.isLoggingIn, expected)
    }

    func testLoginSuccessfulSetsIsAuthenticated() {
        let expected = true

        viewModel.user.username = "admin"
        viewModel.user.password = "admin"
        viewModel.login()
        
        let expectation = expectation(description: "Login success")
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5)
        
        XCTAssertEqual(viewModel.isAuthenticated, expected)
    }

    func testLoginFailureSetsErrorMessage() {
        viewModel.user.username = "wrong_username"
        viewModel.user.password = "wrong_password"
        
        viewModel.login()
        
        let expectation = expectation(description: "Login failure")
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5)
        
        XCTAssertNotNil(viewModel.errorMessage)
    }
}
