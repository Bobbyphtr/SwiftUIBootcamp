//
//  RegisterViewModel.swift
//  SwiftUIBootcamp
//
//  Created by Bobby Pehtrus on 29/01/23.
//

import Foundation
import Combine


enum PhoneError: LocalizedError {
    
    case notCorrectLength
    case wrongFormat
    case notNumber
    
    var errorDescription: String? {
        switch self {
        case .wrongFormat:
            return "Input should begin with 08"
        case .notNumber:
            return "Input should have numbers only"
        case .notCorrectLength:
            return "Input should have 11 - 13 digits only"
        }
    }
}

enum ValidationError: LocalizedError {
    
    case isEmpty
    case custom(_ message: String)
    
    var errorDescription: String? {
        switch self {
        case .isEmpty:
            return "Input should not be empty!"
            
        case .custom(let message):
            return "\(message)"
        }
        
    }
    
}

class RegisterViewModel: ObservableObject {
    
    // Input
    @Published var name: String?
    @Published var age: Int?
    @Published var phoneNumber: String?
    
    // Output
    @Published var phoneNumberValidationError: String?
    @Published var nameValidationError: String?
    @Published var ageValidationError: String?
    
    var isFirstFormValid: AnyPublisher<Bool, Never> {
        return Publishers
            .Zip($nameValidationError, $ageValidationError)
            .map { [weak self] error1, error2 in
                return self?.name != nil && self?.age != nil && [error1, error2].allSatisfy({ $0 == nil })
            }
            .eraseToAnyPublisher()
    }
    
    var isSecondFormValid: AnyPublisher<Bool, Never> {
        return $phoneNumberValidationError
            .map({ self.phoneNumber != nil && $0 == nil })
            .eraseToAnyPublisher()
    }
    
    init() {
        bindErrors()
    }
    
    private func bindErrors() {
        $phoneNumber
            .dropFirst()
            .throttle(for: .milliseconds(200), scheduler: RunLoop.main, latest: true)
            .map { [weak self] in self?.validatePhoneNumber($0)?.errorDescription }
            .assign(to: &$phoneNumberValidationError)
        
        $name
            .dropFirst()
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .map { [weak self] in self?.validateName($0)?.errorDescription }
            .assign(to: &$nameValidationError)
            
        $age
            .dropFirst()
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .map { [weak self] in self?.validateAge($0)?.errorDescription }
            .assign(to: &$ageValidationError)
    }
    
    private func validatePhoneNumber(_ phoneNum: String?) -> LocalizedError? {
        let phoneStr = phoneNum ?? ""
        
        guard !phoneStr.isEmpty else { return ValidationError.isEmpty }
        
        guard phoneStr.count > 2 else { return PhoneError.notCorrectLength }
        
        // get 2 at front
        let index: String.Index = phoneStr.index(phoneStr.startIndex, offsetBy: 2)
        
        if phoneStr[..<index] != "08" {
            return PhoneError.wrongFormat
        }
        
        let regex = try! NSRegularExpression(pattern: "^[0-9]+$")
        if regex.matches(in: phoneStr, range: NSRange(location: 0, length: phoneStr.count)).isEmpty {
            return PhoneError.notNumber
        }
        
        if phoneStr.count < 11 || phoneStr.count > 14 {
            return PhoneError.notCorrectLength
        }
        
        return nil
    }
    
    private func validateName(_ nameStr: String?) -> LocalizedError? {
        guard let name = nameStr else { return ValidationError.isEmpty }
        if name.isEmpty { return ValidationError.isEmpty }
        return nil
    }
    
    private func validateAge(_ ageInt: Int?) -> LocalizedError? {
        guard let age = ageInt else { return ValidationError.isEmpty }
        if age <= 0 { return ValidationError.custom("Age should not be 0!")}
        return nil
    }
    
}
