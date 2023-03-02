//
//  SwiftUIBootcampUITests.swift
//  SwiftUIBootcampUITests
//
//  Created by Bobby Pehtrus on 27/01/23.
//

import Foundation
import XCTest

/*
 
 Some features are not meant to be tested on UITest. This is just for demonstration purposes only.
 UITest is for flows.
 */

final class SwiftUIBootcampUITests: XCTestCase {
    
    
    // This is an okay UITest
    func testRegisterView_whenCompleteRegisterFlow_showWelcomeView() {
        let app = XCUIApplication()
        app.launch()
        
        let nameField = getTextfieldFromElementId(app: app, "register.name.field")
        let ageField = getTextfieldFromElementId(app: app, "register.age.field")
        let nextButton = app.buttons["register.button.next"]
        
        nameField.tap()
        nameField.typeText("Bobby")
        
        ageField.tap()
        ageField.typeText("12")
        
        nextButton.tap()
        
        let phoneField = getTextfieldFromElementId(app: app, "register.phone.field")
        let submitButton = app.buttons["register.button.submit"]
        
        phoneField.tap()
        phoneField.typeText("0818800818880")
        
        submitButton.tap()
        
        let welcomeText1 = app.staticTexts["Welcome, Bobby!"]
        let welcomeText2 = app.staticTexts["You are 12 year(s) old"]
        let welcomeText3 = app.staticTexts["We can call you on 0818800818880"]
        
        XCTAssertTrue(welcomeText1.exists)
        XCTAssertTrue(welcomeText2.exists)
        XCTAssertTrue(welcomeText3.exists)
        
    }
 
    
    // This is an okay UITest. But can be unit tested.
    func testRegisterView_whenViewLoaded_allFieldIsEnabled() throws {
        let app = XCUIApplication()
        app.launch()
        
        let nameField = getTextfieldFromElementId(app: app, "register.name.field")
        let ageField = getTextfieldFromElementId(app: app, "register.age.field")
        let nextButton = app.buttons["register.button.next"]
        
        XCTAssertTrue(nameField.isEnabled, "Name field should be enabled.")
        XCTAssertTrue(ageField.isEnabled, "Age field should be enabled")
        XCTAssertFalse(nextButton.isEnabled, "Next button should be disabled")
        
        // Check if placeholder value has value.
        // This is not a good practice because if the placeholder is changing, the test broke. You can use NSLocalization instead and strings.
        XCTAssertEqual(nameField.placeholderValue, "Name")
        XCTAssertEqual(ageField.placeholderValue, "Age")
        
    }
    
    
    // Unit testable.
    func testViewController_whenEmptyNameTyped_presentErrorLabel() {
        let app = XCUIApplication()
        app.launch()
        
        var stringValue: String
        var deleteString: String
        
        // MARK: - Fill Name and remove it should show error
        
        // arrange
        let nameField = getTextfieldFromElementId(app: app, "register.name.field")
        
        // act
        stringValue = "Type this first"
        nameField.tap()
        nameField.typeText(stringValue)
        
        // empty type later
        deleteString = String(repeating: XCUIKeyboardKey.delete.rawValue, count: stringValue.count + 5)
        nameField.typeText(deleteString)
                
        
        // We have debounce, thus we need to wait for the error to exist.
        XCTAssertTrue(app.staticTexts["Input should not be empty!"].waitForExistence(timeout: 2.0))
    }
    
    // Unit testable.
    func testViewController_whenEmptyAge_presentErrorLabel() {
        let app = XCUIApplication()
        app.launch()
        
        let ageField = getTextfieldFromElementId(app: app, "register.age.field")
        
        // act
        let stringValue = "12"
        ageField.tap()
        ageField.typeText(stringValue)
        
        // empty type later
        let deleteString = String(repeating: XCUIKeyboardKey.delete.rawValue, count: stringValue.count)
        ageField.typeText(deleteString)
        
        // We have debounce, thus we need to wait for the error to exist.
        XCTAssertTrue(app.staticTexts["Input should not be empty!"].waitForExistence(timeout: 2.0))
    }
    
    // Unit testable.
    func testViewController_when0Age_presentErrorLabel() {
        let app = XCUIApplication()
        app.launch()
        
        // MARK: - Fill age and remove it should show error
        let ageField = getTextfieldFromElementId(app: app, "register.age.field")
        
        // act
        let stringValue = "0"
        ageField.tap()
        ageField.typeText(stringValue)
        
        // We have debounce, thus we need to wait for the error to exist.
        XCTAssertTrue(app.staticTexts["Age should not be 0!"].waitForExistence(timeout: 1.0))
    }
    
}


extension XCTestCase {
    
    func getTextfieldFromElementId(app: XCUIApplication, _ accessibilityIdentifier: String) -> XCUIElement {
        return app.otherElements[accessibilityIdentifier].children(matching: .textField)["borderedtextfield.textfield"]
        
        
    }
    
    func getErrorTextFromElementId(app: XCUIApplication, _ accessibilityIdentifier: String) -> XCUIElement {
        return app.otherElements[accessibilityIdentifier].children(matching: .staticText)["borderedtextfield.errortext"]
    }
}
