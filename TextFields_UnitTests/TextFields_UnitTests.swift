//
//  TextFields_UnitTests.swift
//  TextFields_UnitTests
//
//  Created by Данік on 27/02/2023.
//

import XCTest

final class TextFields_UnitTests: XCTestCase {
    let viewController = ViewController()
    
    func test_only_allow_letters() {
        let allowLetters = viewController.onlyAllowText(string: "Stringwithnodigits")
        let expectedResult = true
        XCTAssertEqual(allowLetters, expectedResult)
    }
    
    func test_only_allow_letters_and_spaces() {
        let allowLetters = viewController.onlyAllowText(string: "String with with spaces and no digits")
        let expectedResult = true
        XCTAssertEqual(allowLetters, expectedResult)
    }
    
}


