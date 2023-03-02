//
//  WelcomeView.swift
//  SwiftUIBootcamp
//
//  Created by Bobby Pehtrus on 27/02/23.
//

import SwiftUI

struct WelcomeView: View {
    
    private let name: String
    private let age: Int
    private let phoneNumber: String
    
    init(name: String, age: Int, phoneNumber: String) {
        self.name = name
        self.age = age
        self.phoneNumber = phoneNumber
    }
    
    var body: some View {
        ZStack {
            Color.green
                .ignoresSafeArea()
            VStack {
                Text("Welcome, \(name)!")
                    .font(.title)
                    .fontWeight(.bold)
                Text("You are \(age) year(s) old")
                    .padding(.top, 8.0)
                Text("We can call you on \(phoneNumber)")
            }
            .foregroundColor(Color.white)
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView(name: "Bobby", age: 20, phoneNumber: "0898142578")
    }
}
