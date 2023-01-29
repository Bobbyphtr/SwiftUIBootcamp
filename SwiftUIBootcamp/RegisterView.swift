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
    
    var body: some View {
        VStack {
            Text("Welcome to SwiftUI")
                .font(Font.title)
                .fontWeight(.semibold)
            Text("Register here!")
                .multilineTextAlignment(.center)
                .padding(.bottom, 16.0)
            
            VStack(spacing: 16.0) {
                BorderedTextField(placeholder: "Name", textBind: $viewModel.name)
                BorderedTextField(placeholder: "Age", textBind: $ageText)
                    .onChange(of: ageText, perform: { newValue in
                        // Convert into Integers
                        self.viewModel.age = Int(newValue) ?? -1
                    })
                    .keyboardType(.numberPad)
Button {
    // Submit action
    print("Name: \(viewModel.name)")
    print("Age: \(viewModel.age)")
    print("PhoneNumber: \(viewModel.phoneNumber)")
} label: {
    NavigationLink("Next") {
        PhoneNumberView()
    }
    .frame(maxWidth: .infinity)
    .padding(8.0)
}
.buttonStyle(.borderedProminent)
            } // - Register Form
            Text("RegisterViewModel")
            Text("Name: \(viewModel.name)")
            Text("Age: \(viewModel.age)")
        } // - Main Stack
        .padding(.horizontal, 16.0)
    }
}

struct BorderedTextField: View {
    /// Placeholder localize string key
    private var placeholder: LocalizedStringKey
    
    /// Text binding.
    @Binding
    private var textBind: String
    
    /// Initialize a textfield with bordered pattern
    /// - Parameters:
    ///   - placeholder: Localized Key for Placeholder.
    ///   - textBind: Text binding
    init(placeholder: LocalizedStringKey, textBind: Binding<String>) {
        self.placeholder = placeholder
        self._textBind = textBind
    }
    
    var body: some View {
        TextField(placeholder, text: $textBind)
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 8.0)
                    .stroke()
            )
    }
}

// MARK: - Previews
struct Previews_RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
