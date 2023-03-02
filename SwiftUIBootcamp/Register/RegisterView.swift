//
//  RegisterView.swift
//  SwiftUIBootcamp
//
//  Created by Bobby Pehtrus on 29/01/23.
//

import SwiftUI

struct RegisterView: View {
    
    @EnvironmentObject var viewModel: RegisterViewModel
    
    /// We because textfield need a string binding.
    @State var ageText: String = ""
    @State var nameText: String = ""

    @State var isFormValid: Bool = false
    
    var body: some View {
        VStack {
            Text("Welcome to SwiftUI")
                .font(Font.title)
                .fontWeight(.semibold)
            Text("Register here!")
                .multilineTextAlignment(.center)
                .padding(.bottom, 16.0)
            
            VStack(spacing: 16.0) {
                BorderedTextField(placeholder: "Name",
                                  textBind: $nameText,
                                  errorTextBind: $viewModel.nameValidationError)
                .onChange(of: nameText) { newValue in
                    self.viewModel.name = newValue.isEmpty ? nil : newValue
                }
                .accessibilityIdentifier("register.name.field")
                
                BorderedTextField(placeholder: "Age",
                                  textBind: $ageText,
                                  errorTextBind: $viewModel.ageValidationError)
                .onChange(of: ageText, perform: { newValue in
                    // Convert into Integers
                    self.viewModel.age = Int(newValue)
                })
                .accessibilityIdentifier("register.age.field")
                .keyboardType(.numberPad)
                Button {
                    // Submit action
                } label: {
                    NavigationLink("Next") {
                        PhoneNumberView()
                    }
                    .frame(maxWidth: .infinity)
                    .padding(8.0)
                }
                .disabled(!isFormValid)
                .buttonStyle(.automatic)
                .accessibilityIdentifier("register.button.next")
            } // - Register Form
            Text("RegisterViewModel")
            Text("Name: \(viewModel.name ?? "nil")")
            Text("Age: \(viewModel.age == nil ? "nil" : String(viewModel.age!))")
        } // - Main Stack
        .padding(.horizontal, 16.0)
        .onReceive(self.viewModel.isFirstFormValid
            .throttle(for: .milliseconds(500), scheduler: RunLoop.main, latest: true)
        ) { output in
            self.isFormValid = output
        }
    }
    
}

struct BorderedTextField: View {
    /// Placeholder localize string key
    private var placeholder: LocalizedStringKey
    
    /// Text binding.
    @Binding
    private var textBind: String
    
    @Binding
    private var errorTextBind: String?
    
    /// Initialize a textfield with bordered pattern
    /// - Parameters:
    ///   - placeholder: Localized Key for Placeholder.
    ///   - textBind: Text binding
    init(placeholder: LocalizedStringKey,
         textBind: Binding<String>,
         errorTextBind: Binding<String?>? = nil) {
        self.placeholder = placeholder
        self._textBind = textBind
        self._errorTextBind = errorTextBind ?? Binding<String?>.constant(nil)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            TextField(placeholder, text: $textBind)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 8.0)
                        .stroke()
                )
                .accessibilityIdentifier("borderedtextfield.textfield")
            Text(errorTextBind ?? "")
                .foregroundColor(Color.red)
                .accessibilityIdentifier("borderedtextfield.errortext")
        }
        
    }
}

// MARK: - Previews
struct Previews_RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
            .environmentObject(RegisterViewModel())
    }
}
