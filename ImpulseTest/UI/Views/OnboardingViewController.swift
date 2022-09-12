//
//  SecondViewController.swift
//  ImpulseTest
//
//  Created by Diana on 09.09.2022.
//

import UIKit
import CoreData

class OnboardingViewController: UIViewController {
    
    var collectionView : UICollectionView!
    var timerScreenWasShown = Bool()
    
    let coreDataManager = CoreDataManager()
    
    let pages = [
        Page(imageName: "Image1", headerText: "Boost Productivity", bodyText: "Take your productivity to the next level"),
        Page(imageName: "Image2", headerText: "Work Seamlessly", bodyText: "Get your work done seamlessly without interruption"),
        Page(imageName: "Image3", headerText: "Achieve Your Goals", bodyText: "Boosted productivity will help you achieve the desired goals")
    ]
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPage = 0
        pageControl.numberOfPages = pages.count
        pageControl.isUserInteractionEnabled = false
        return pageControl
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = .impulseBoldFont
        button.backgroundColor = .mainButtonColor
        button.setTitleColor(.secondarySystemBackground, for: .normal)
        button.setTitle("Next", for: .normal)
        button.addTarget(self, action: #selector(handleNextTap), for: .touchUpInside)
        button.layer.cornerRadius = 10
        button.contentHorizontalAlignment = .center
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    var currentPage = 0 {
        didSet {
            pageControl.currentPage = currentPage
            if currentPage == pages.count - 1 {
                nextButton.setTitle("Continue", for: .normal)
            } else {
                nextButton.setTitle("Next", for: .normal)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addCollectionView()
        
        setupBottomControls()
        timerScreenWasShown = coreDataManager.getData()
    }
    
    func addCollectionView() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .white
        collectionView.register(PageCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.backgroundColor = .mainBackgroundColor
        collectionView.isPagingEnabled = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor)
        ])
    }
    
    fileprivate func setupBottomControls() {
        let bottomControlsStackView = UIStackView(arrangedSubviews: [pageControl, nextButton])
        bottomControlsStackView.translatesAutoresizingMaskIntoConstraints = false
        bottomControlsStackView.distribution = .fillProportionally
        bottomControlsStackView.axis = .vertical
        view.addSubview(bottomControlsStackView)
        
        NSLayoutConstraint.activate([
            bottomControlsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            bottomControlsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bottomControlsStackView.heightAnchor.constraint(equalToConstant: 100),
            bottomControlsStackView.widthAnchor.constraint(equalToConstant: view.frame.width/1.25)
        ])
    }
    
    @objc private func handleNextTap() {
        if currentPage == pages.count - 1 {
            actionForContinueButton()
        } else {
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            pageControl.currentPage = currentPage
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
    
    private func openTimerVC() {
        let timerVC = ViewControllerFactory.viewController(for: .timerVC)
        present(timerVC, animated: true)
    }
    
    private func showAlert() {
        let alertTitle = "Thank you for your interest"
        let alertMessage = "The functionality is under development"
        Alert.present(title: alertTitle, message: alertMessage, from: self)
    }
    
    private func actionForContinueButton() {
        if !timerScreenWasShown {
            openTimerVC()
        } else {
            showAlert()
        }
    }
}

extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PageCell
        let page = pages[indexPath.item]
        cell.page = page
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
    }
}
