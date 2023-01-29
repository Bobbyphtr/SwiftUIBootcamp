//
//  PhoneNumberView.swift
//  SwiftUIBootcamp
//
//  Created by Bobby Pehtrus on 29/01/23.
//

import SwiftUI

struct PhoneNumberView: View {
    
    @EnvironmentObject var registerVM: RegisterViewModel
    
    var body: some View {
        VStack {
            Text("OTP Confirmation")
            VStack(spacing: 16.0) {
                BorderedTextField(placeholder: "+62 Phone Number", textBind: $registerVM.phoneNumber)
                Button {
                    print("Name: \(registerVM.name)")
                    print("Age: \(registerVM.age)")
                    print("PhoneNumber: \(registerVM.phoneNumber)")
                } label: {
                    Text("Submit")
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 8.0)
                }
                .buttonStyle(.borderedProminent)
            }
            
        }
        .padding(.horizontal)
    }
}

struct PhoneNumberView_Previews: PreviewProvider {
    static var previews: some View {
        PhoneNumberView()
    }
}
