//
//  HelloWorldViewController.swift
//  SwiftUIBootcamp
//
//  Created by Bobby Pehtrus on 27/01/23.
//

import Foundation
import UIKit

class HelloWorldViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let globeImage: UIImageView = UIImageView()
        globeImage.translatesAutoresizingMaskIntoConstraints = false
        globeImage.image = UIImage(systemName: "globe") ?? UIImage()
        
        let nameLabel: UILabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.text = "Name Label"
        
        let ageLabel: UILabel = UILabel()
        ageLabel.translatesAutoresizingMaskIntoConstraints = false
        ageLabel.text = "Age Label"
        
        let mainStackView: UIStackView = UIStackView(arrangedSubviews: [globeImage, nameLabel, ageLabel])
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.axis = .vertical
        mainStackView.alignment = .center
        
        view.addSubview(mainStackView)
        
        NSLayoutConstraint.activate([
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
