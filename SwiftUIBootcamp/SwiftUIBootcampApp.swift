//
//  SwiftUIBootcampApp.swift
//  SwiftUIBootcamp
//
//  Created by Bobby Pehtrus on 27/01/23.
//

import SwiftUI

@main
struct SwiftUIBootcampApp: App {
    
    private var registerViewModel : RegisterViewModel = RegisterViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                RegisterView()
            }
            .environmentObject(registerViewModel)
        }
    }
}

struct ViewControllerRepresentable: UIViewControllerRepresentable {

    typealias UIViewControllerType = UIViewController
    
    func makeUIViewController(context: Context) -> UIViewController {
        return UINavigationController(rootViewController: HelloWorldViewController())
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        //
    }
    
}
