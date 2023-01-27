//
//  ContentView.swift
//  SwiftUIBootcamp
//
//  Created by Bobby Pehtrus on 27/01/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .foregroundColor(.accentColor)
            Text("Name Label")
            Text("Age Label")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
