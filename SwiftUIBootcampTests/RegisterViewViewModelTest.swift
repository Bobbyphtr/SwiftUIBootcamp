//
//  RegisterViewViewModelTest.swift
//  SwiftUIBootcampTests
//
//  Created by Bobby Pehtrus on 17/02/23.
//

import Combine
import Nimble
import Quick

@testable import SwiftUIBootcamp

final class RegisterViewViewModelTest: QuickSpec {
    
    override func spec() {
        
        var sut: RegisterViewModel!
        var cancellables: Set<AnyCancellable>!
        
        describe("ValidationTest") {
            
            beforeEach {
                sut = RegisterViewModel()
                cancellables = []
            }
            
            afterEach {
                cancellables = nil
            }
            
            context("PhoneNumber validation") {
                
                /// Valid if
                /// 1. number has "08" at the beginning
                /// 2. only contains number
                /// 3. has minimum 11 digits and max 14 digits
                
                it("should pass on valid phoneNumber change") {
                    
                    let phoneInput: String = "08981382023"
                    
                    sut.phoneNumber = phoneInput
                    
                    expect(sut.phoneNumberValidationError).toEventually(beNil(),
                                                                        timeout: .seconds(1))
                }
                
                it("should failed if phone format under 11 digits") {
                    
                    // arrange
                    let phoneInput: String = "08234"
                    
                    // act
                    sut.phoneNumber = phoneInput
                    
                    expect(sut.phoneNumberValidationError)
                        .toEventually(equal(PhoneError.notCorrectLength.errorDescription),
                                      timeout: .seconds(1))
                }
                
                it("should failed if phone format over 14 digits") {
                    
                    // arrange
                    let phoneInput: String = "0823423920940123"
                    
                    // act
                    sut.phoneNumber = phoneInput
                    
                    expect(sut.phoneNumberValidationError)
                        .toEventually(equal(PhoneError.notCorrectLength.errorDescription),
                                      timeout: .seconds(1))
                }
                
                
                it("should failed if phone format has no 08") {
                    // arrange
                    let phoneInput: String = "1234567823"
                    
                    // act
                    sut.phoneNumber = phoneInput
                    
                    expect(sut.phoneNumberValidationError)
                        .toEventually(equal(PhoneError.wrongFormat.errorDescription),
                                      timeout: .seconds(1))
                }
                
                it("should failed if phone format has letters") {
                    // arrange
                    let phoneInput: String = "08a23fa4s12s"
                    
                    // act
                    sut.phoneNumber = phoneInput
                    
                    expect(sut.phoneNumberValidationError)
                        .toEventually(equal(PhoneError.notNumber.errorDescription))
                }
                
it("should failed if phone format under 11 digits") {
    // Set expectations!
    let expectation = XCTestExpectation(description: "Phone number error not triggered yet!")
    // arrange
    let phoneInput: String = "08234"
    
    sut.$phoneNumberValidationError
        .dropFirst()
        .sink { value in
            // Assert!
            expect(value).to(equal(PhoneError.notCorrectLength.errorDescription))
            expectation.fulfill()
        }
        .store(in: &cancellables)
    
    // act
    sut.phoneNumber = phoneInput
    
    self.wait(for: [expectation], timeout: 1.0)
}
                
            }
        }
        
        context("Age validation") {
            
            //            it("should pass if age is more than 0") {
            //
            //                // act
            //                sut.age = -1
            //                expect(sut.ageValidationError).toNever(beNil(),
            //                                                            timeout: .seconds(1), pollInterval: .milliseconds(500))
            //
            //            }
            
            it("should failed if age is empty") {
                
                // arrange
                let ageInput: Int? = nil
                
                // act
                sut.age = ageInput
                
                expect(sut.ageValidationError).toEventually(equal(ValidationError.isEmpty.errorDescription), timeout: .seconds(1))
            }
            
            it("should failed if age is 0") {
                
                // arrange
                let ageInput: Int = 0
                
                // act
                sut.age = ageInput
                
                // assert
                expect(sut.ageValidationError).toEventually(equal(ValidationError.custom("Age should not be 0!").errorDescription))
            }
            
        }
        
        context("Name validation") {
            
            //            it("should pass if name is exist") {
            //                sut.name = nil
            //
            //                expect(sut.nameValidationError).toEventually(beNil())
            //            }
            
            it("should failed if name is nil") {
                
                sut.name = nil
                
                expect(sut.nameValidationError).toEventually(equal(ValidationError.isEmpty.errorDescription))
            }
            
            it("should failed if name is empty string") {
                sut.name = ""
                
                expect(sut.nameValidationError).toEventually(equal(ValidationError.isEmpty.errorDescription))
            }
            
        }
        
    }
    
}

extension QuickSpec {
    
    enum AwaitPublisherStrategy {
        case poolUntil(timeInterval : TimeInterval)
        case dropFirstAndReceive
        case receiveFirst
        case receiveLastUntil(timeInterval: TimeInterval)
    }
    
    func awaitPublisher<T: Publisher>(
        _ publisher: T,
        awaitStrategy: AwaitPublisherStrategy,
        timeout: TimeInterval = 1,
        file: StaticString = #file,
        line: UInt = #line
    ) throws -> [T.Output] {
        // This time, we use Swift's Result type to keep track
        // of the result of our Combine pipeline:
        var result: Result<[T.Output], Error>?
        let expectation = self.expectation(description: "Awaiting publisher")
        
        var eventCount: Int = 0
        var events: [T.Output] = []
        
        let cancellable = publisher.sink(
            receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    result = .failure(error)
                case .finished:
                    break
                }
                
                expectation.fulfill()
            },
            receiveValue: { value in
                switch awaitStrategy {
                case .poolUntil(let interval):
                    fatalError("Not supported")
                    break
                case .dropFirstAndReceive:
                    if eventCount > 0 {
                        result = .success([value])
                    }
                    break
                case .receiveFirst:
                    result = .success([value])
                case .receiveLastUntil(let interval):
                    fatalError("Not supported")
                }
                eventCount += 1
            }
        )
        
        
        // Just like before, we await the expectation that we
        // created at the top of our test, and once done, we
        // also cancel our cancellable to avoid getting any
        // unused variable warnings:
        waitForExpectations(timeout: timeout)
        cancellable.cancel()
        
        // Here we pass the original file and line number that
        // our utility was called at, to tell XCTest to report
        // any encountered errors at that original call site:
        let unwrappedResult = try XCTUnwrap(
            result,
            "Awaited publisher did not produce any output",
            file: file,
            line: line
        )
        
        return try unwrappedResult.get()
    }
    
}
