//
//  RegisterViewModelXCTests.swift
//  SwiftUIBootcampTests
//
//  Created by Bobby Pehtrus on 28/02/23.
//

import Combine
import XCTest
@testable import SwiftUIBootcamp

final class RegisterViewModelXCTests: XCTestCase {
    
    private var sut: RegisterViewModel!
    private var cancellables: Set<AnyCancellable> = []
    override func setUp() {
        sut = RegisterViewModel()
    }
    
    func test_registerViewModel_shouldPassOnValidPhoneNumber() {
        
        let expectation: XCTestExpectation = XCTestExpectation(description: "Phone number is not validated yet")
        
        sut.$phoneNumberValidationError
            .dropFirst()
            .sink { errorMsg in
                XCTAssertNil(errorMsg)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        sut.phoneNumber = "08981382023"
        
        wait(for: [expectation], timeout: 1.0)
        
    }
    
    func test_registerViewModel_shouldFailIfPhoneBelow11Digits() {
        let expectation: XCTestExpectation = XCTestExpectation(description: "Phone number is not validated yet")
        
        sut.$phoneNumberValidationError
            .dropFirst()
            .sink { errorMsg in
                XCTAssertEqual(errorMsg, PhoneError.notCorrectLength.errorDescription)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        sut.phoneNumber = "089930333"
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_registerViewModel_shouldFailIfPhoneOver14Digits() {
        let expectation: XCTestExpectation = XCTestExpectation(description: "Phone number is not validated yet")
        
        sut.$phoneNumberValidationError
            .dropFirst()
            .sink { errorMsg in
                XCTAssertEqual(errorMsg, PhoneError.notCorrectLength.errorDescription)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        sut.phoneNumber = "089930332320812030"
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_registerViewModel_shouldFailIfPhoneContainsLetters() {
        let expectation: XCTestExpectation = XCTestExpectation(description: "Phone number is not validated yet")
        
        sut.$phoneNumberValidationError
            .dropFirst()
            .sink { errorMsg in
                XCTAssertEqual(errorMsg, PhoneError.notNumber.errorDescription)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        sut.phoneNumber = "089930sjds333"
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_registerViewModel_shouldFailIfPhonePrefixNot08() {
        let expectation: XCTestExpectation = XCTestExpectation(description: "Phone number is not validated yet")
        
        sut.$phoneNumberValidationError
            .dropFirst()
            .sink { errorMsg in
                XCTAssertEqual(errorMsg, PhoneError.wrongFormat.errorDescription)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        sut.phoneNumber = "123899330293"
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    
}
