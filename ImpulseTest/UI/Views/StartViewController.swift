//
//  ViewController.swift
//  ImpulseTest
//
//  Created by Diana on 09.09.2022.
//

import UIKit

class StartViewController: UIViewController {
    
    private let startButton: UIButton = {
        let startButton = UIButton()
        startButton.setTitle("Start", for: .normal)
        startButton.titleLabel?.font = .impulseBoldFont
        startButton.backgroundColor = .mainButtonColor
        startButton.translatesAutoresizingMaskIntoConstraints = false
        startButton.layer.cornerRadius = 10
        return startButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .mainBackgroundColor
        view.addSubview(startButton)
        startButton.addTarget(self, action: #selector(openOnboardingVC), for: .touchUpInside)
        
        addConstraintsStartButton()
    }
    
    private func addConstraintsStartButton() {
        NSLayoutConstraint.activate([
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            startButton.heightAnchor.constraint(equalToConstant: 52),
            startButton.widthAnchor.constraint(equalToConstant: 244)
        ])
    }
    
    @objc private func openOnboardingVC() {
        let onboardingVC = ViewControllerFactory.viewController(for: .onboardingVC)
        present(onboardingVC, animated: true)
    }
}

