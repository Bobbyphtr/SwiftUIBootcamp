//
//  RegisterViewModel.swift
//  SwiftUIBootcamp
//
//  Created by Bobby Pehtrus on 29/01/23.
//

import Foundation
import Combine

class RegisterViewModel: ObservableObject {
    
    @Published var name: String
    @Published var age: Int
    @Published var phoneNumber:  String
    
    init(name: String = "", age: Int = 0, phoneNumber: String = "") {
        self.name = name
        self.age = age
        self.phoneNumber = phoneNumber
    }
    
}
