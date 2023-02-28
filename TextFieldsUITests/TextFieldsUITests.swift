//
//  TextFieldsUITests.swift
//  TextFieldsUITests
//
//  Created by Данік on 27/02/2023.
//

import XCTest

final class TextFieldsUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        // NoDigitsTextField
        let noDigitsTextField = app.textFields.element(matching: .any, identifier: "noDigitsField")
        XCTAssertTrue(noDigitsTextField.exists)
        noDigitsTextField.tap()
        noDigitsTextField.typeText("String with 123 digits")
        XCTAssertEqual(noDigitsTextField.value as! String, "String with  digits")
        
        // TextField with input Limits
        let inputLimit = app.textFields.element(matching: .any, identifier: "inputLimit")
        let countLabel = app.staticTexts.element(matching: .any, identifier: "countLabel")
        XCTAssertTrue(inputLimit.exists)
        XCTAssertTrue(countLabel.exists)
        inputLimit.tap()
        inputLimit.typeText("12345678910")
        XCTAssertEqual(countLabel.label, "11/10")

        // Only characters
        let onlyCharacters = app.textFields.element(matching: .any, identifier: "onlyCharacters")
        XCTAssertTrue(onlyCharacters.exists)
        onlyCharacters.tap()
        onlyCharacters.typeText("abcde-12345")
        XCTAssertEqual(onlyCharacters.value as! String, "abcde-12345")
        onlyCharacters.typeText("\n")
        
        
        // Password TextField
        let passwordTextField = app.textFields.element(matching: .any, identifier: "passwordTextField")
        XCTAssertTrue(passwordTextField.exists)
        // Labels to check for a change
        let eightChar = app.staticTexts.element(matching: .any, identifier: "eightChar")
        XCTAssertTrue(eightChar.exists)
        let oneDig = app.staticTexts.element(matching: .any, identifier: "oneDig")
        XCTAssertTrue(oneDig.exists)
        let oneLowercase = app.staticTexts.element(matching: .any, identifier: "oneLowercase")
        XCTAssertTrue(oneLowercase.exists)
        let oneCapital = app.staticTexts.element(matching: .any, identifier: "oneCapital")
        XCTAssertTrue(oneDig.exists)
        
        // check for 1 lowercase
        passwordTextField.tap()
        passwordTextField.typeText("a")
        passwordTextField.typeText("\n")
        XCTAssertEqual(oneLowercase.label, "✓ min 1 lowercase.")
        
        // check for 1 capital
        passwordTextField.tap()
        passwordTextField.typeText("A")
        passwordTextField.typeText("\n")
        XCTAssertEqual(oneCapital.label, "✓ min 1 capital required.")
        
        // check for 1 digit
        passwordTextField.tap()
        passwordTextField.typeText("8")
        passwordTextField.typeText("\n")
        XCTAssertEqual(oneDig.label, "✓ min 1 digit.")
        
        // check for 8 characters
        passwordTextField.tap()
        passwordTextField.typeText("password")
        passwordTextField.typeText("\n")
        XCTAssertEqual(eightChar.label, "✓ min length 8 characters.")
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
