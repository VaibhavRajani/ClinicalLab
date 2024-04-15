//
//  AdminLoginViewUITests.swift
//  ClinicalLabUITests
//
//  Created by Vaibhav Rajani on 3/20/24.
//

import Foundation
import XCTest

class AdminLoginViewUITests: XCTestCase {
    let app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }

    func testSuccessfulLogin() {
        let logOutButton = app.buttons["LogOutButton"]
        let usernameTextField = app.textFields["Username"]
        XCTAssertTrue(usernameTextField.exists)
        usernameTextField.tap()
        usernameTextField.typeText("admin")
        
        let passwordSecureTextField = app.secureTextFields["Password"]
        XCTAssertTrue(passwordSecureTextField.exists)
        passwordSecureTextField.tap()
        passwordSecureTextField.typeText("admin")
        
        app.buttons["Login"].tap()
        
        let exists = NSPredicate(format: "exists == 1")
        expectation(for: exists, evaluatedWith: logOutButton, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssert(logOutButton.exists)
    }
}
