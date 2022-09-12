//
//  TimerViewController.swift
//  ImpulseTest
//
//  Created by Diana on 10.09.2022.
//

import UIKit
import CoreData

class TimerViewController: UIViewController {
    private var seconds = 60
    
    private let timerView = UIView()
    private let timerHeight = UIScreen.main.bounds.height / 2
    private let timerWidth = UIScreen.main.bounds.width / 1.1
    private let coreDataManager = CoreDataManager()
    
    private lazy var backdropView: UIView = {
        let bdView = UIView(frame: self.view.bounds)
        bdView.backgroundColor = .black.withAlphaComponent(0.5)
        return bdView
    }()
    
    private var timerLabel: UILabel = {
        let timerLabel = UILabel()
        timerLabel.text = "01:00"
        timerLabel.font = .impulseLargeFont
        timerLabel.textAlignment = .center
        timerLabel.textColor = .secondarySystemBackground
        timerLabel.translatesAutoresizingMaskIntoConstraints = false
        return timerLabel
    }()
    
    private let progressView: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .bar)
        progressView.trackTintColor = .darkGray
        progressView.progressTintColor = .mainButtonColor
        progressView.layer.cornerRadius = 5
        progressView.progress = 0.0
        progressView.clipsToBounds = true
        return progressView
    }()
    
    private lazy var continueButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = .impulseBoldFont
        button.backgroundColor = .unActiveColor
        button.setTitleColor(.lightGray, for: .normal)
        button.setTitle("Continue", for: .normal)
        button.layer.cornerRadius = 10
        button.contentHorizontalAlignment = .center
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled = false
        button.addTarget(self, action: #selector(goOnPreviousOnboardingScreen), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .clear
        view.addSubview(backdropView)
        
        addTimer()
        addTimeLabel()
    }
    
    func addTimer() {
        view.addSubview(timerView)
        
        timerView.backgroundColor = .mainBackgroundColor
        timerView.layer.cornerRadius = 10
        timerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            timerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            timerView.heightAnchor.constraint(equalToConstant: timerHeight),
            timerView.widthAnchor.constraint(equalToConstant: timerWidth)
        ])
        
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    func addTimeLabel() {
        let timerStackView = UIStackView(arrangedSubviews: [timerLabel, progressView, continueButton])
        timerStackView.translatesAutoresizingMaskIntoConstraints = false
        timerStackView.distribution = .equalCentering
        timerStackView.spacing = 50
        timerStackView.axis = .vertical
        view.addSubview(timerStackView)
        
        NSLayoutConstraint.activate([
            timerStackView.topAnchor.constraint(equalTo: timerView.topAnchor, constant: 96),
            timerStackView.centerXAnchor.constraint(equalTo: timerView.centerXAnchor),
            timerStackView.centerYAnchor.constraint(equalTo: timerView.centerYAnchor),
            timerStackView.bottomAnchor.constraint(equalTo: timerView.bottomAnchor, constant: -32),
            timerStackView.widthAnchor.constraint(equalTo: timerView.widthAnchor, multiplier: 0.8),
            progressView.heightAnchor.constraint(equalToConstant: 8),
            continueButton.topAnchor.constraint(equalTo: progressView.bottomAnchor, constant: 124),
            continueButton.widthAnchor.constraint(equalToConstant: progressView.frame.width),
            continueButton.heightAnchor.constraint(equalToConstant: 52),
        ])
    }
    
    func convertSecondsToTime(timeInSeconds: Int) -> String {
        let minutes = timeInSeconds / 60
        let seconds = timeInSeconds % 60
        return String(format: "%02i:%02i", minutes, seconds)
    }
    
    @objc func updateTime() {
        let maxProgressView: Float = 1.0
        let maxSeconds: Float = 60.0
        timerLabel.text = convertSecondsToTime(timeInSeconds: seconds)
        if seconds > 0 {
            seconds -= 1
        } else {
            continueButton.isUserInteractionEnabled = true
            continueButton.backgroundColor = .mainButtonColor
            continueButton.setTitleColor(.secondarySystemBackground, for: .normal)
        }
        
        UIView.animate(withDuration: 3, animations: {
            self.progressView.setProgress((self.progressView.progress + maxProgressView/maxSeconds), animated: true)
        })
    }
    
    @objc func goOnPreviousOnboardingScreen() {
        let onboardingVC = ViewControllerFactory.viewController(for: .onboardingVC)
        coreDataManager.timerScreenWasShown = true
        coreDataManager.saveData(timerScreenWasShown: coreDataManager.timerScreenWasShown)
        present(onboardingVC, animated: true)
    }
}
