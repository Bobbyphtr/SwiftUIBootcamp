//
//  PhoneNumberView.swift
//  SwiftUIBootcamp
//
//  Created by Bobby Pehtrus on 29/01/23.
//

import SwiftUI

struct PhoneNumberView: View {
    
    @EnvironmentObject var registerVM: RegisterViewModel
    
    @State var phoneNumberText: String = ""
    
    @State var isFormValid: Bool = false
    
    var body: some View {
        VStack {
            Text("OTP Confirmation")
            VStack(spacing: 16.0) {
                BorderedTextField(placeholder: "+62 Phone Number",
                                  textBind: $phoneNumberText,
                                  errorTextBind: $registerVM.phoneNumberValidationError)
                    .onChange(of: phoneNumberText) { newValue in
                        self.registerVM.phoneNumber = newValue.isEmpty ? nil : newValue
                    }
                    .keyboardType(.phonePad)
                    .accessibilityIdentifier("register.phone.field")
                Button {
                    
                } label: {
                    NavigationLink {
                        WelcomeView(name: registerVM.name ?? "",
                                    age: registerVM.age ?? 0,
                                    phoneNumber: registerVM.phoneNumber ?? "")
                    } label: {
                        Text("Submit")
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 8.0)
                    }
                }
                .accessibilityIdentifier("register.button.submit")
                .disabled(!isFormValid)
                .buttonStyle(.automatic)
            }
        }
        .padding(.horizontal)
        .onReceive(registerVM.isSecondFormValid) { output in
            self.isFormValid = output
        }
        .onAppear {
            phoneNumberText = registerVM.phoneNumber ?? ""
        }
    }
}

struct PhoneNumberView_Previews: PreviewProvider {
    static var previews: some View {
        PhoneNumberView()
            .environmentObject(RegisterViewModel())
    }
}
