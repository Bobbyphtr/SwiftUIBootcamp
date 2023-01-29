//
//  RegisterView.swift
//  SwiftUIBootcamp
//
//  Created by Bobby Pehtrus on 29/01/23.
//

import SwiftUI

struct RegisterView: View {
    
    @State var nameText: String = ""
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
                BorderedTextField(placeholder: "Name", textBind: $nameText)
                BorderedTextField(placeholder: "Age", textBind: $ageText)
                    .keyboardType(.numberPad)
                Button {
                    // submit action
                } label: {
                    Text("Submit")
                        .frame(maxWidth: .infinity)
                        .padding(8.0)
                }
                .buttonStyle(.borderedProminent)
            } // - Register Form
            Text("Name: \(nameText)")
            Text("Age: \(ageText)")
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
