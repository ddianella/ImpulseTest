//
//  PageCell.swift
//  ImpulseTest
//
//  Created by Diana on 09.09.2022.
//

import UIKit

class PageCell: UICollectionViewCell {
    
    var page: Page? {
        didSet {
            guard let unwrappedPage = page else { return }
            pageImageView.image = UIImage(named: unwrappedPage.imageName)
            
            let attributedText = NSMutableAttributedString(string: unwrappedPage.headerText, attributes: [NSAttributedString.Key.font: .impulseBiggerFont ?? UIFont.boldSystemFont(ofSize: 28), NSMutableAttributedString.Key.foregroundColor: UIColor.secondarySystemBackground])
            
            attributedText.append(NSAttributedString(string: "\n\n\(unwrappedPage.bodyText)", attributes: [NSAttributedString.Key.font: .impulseRegularFont ?? UIFont.systemFont(ofSize: 16), NSMutableAttributedString.Key.foregroundColor: UIColor.secondarySystemBackground]))
            descriptionTextView.attributedText = attributedText
            descriptionTextView.textAlignment = .center
        }
    }
    
    private let pageImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "Image1"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let descriptionTextView: UITextView = {
        let textView = UITextView()
        let attributedText = NSMutableAttributedString(string: "Boost Productivity")
        attributedText.append(NSAttributedString(string: "\n\nTake your productivity to the next level"))
        textView.attributedText = attributedText
        textView.textAlignment = .center
        textView.backgroundColor = .clear
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.isSelectable = false
        return textView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpLayout()
    }
    
    private func setUpLayout() {
        let topImageContainerView = UIView()
        addSubview(topImageContainerView)
        topImageContainerView.translatesAutoresizingMaskIntoConstraints = false
        topImageContainerView.addSubview(pageImageView)
        addSubview(descriptionTextView)
        NSLayoutConstraint.activate([
            topImageContainerView.topAnchor.constraint(equalTo: topAnchor),
            topImageContainerView.leftAnchor.constraint(equalTo: leftAnchor),
            topImageContainerView.rightAnchor.constraint(equalTo: rightAnchor),
            topImageContainerView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5),
            
            pageImageView.centerXAnchor.constraint(equalTo: topImageContainerView.centerXAnchor),
            pageImageView.centerYAnchor.constraint(equalTo: topImageContainerView.centerYAnchor),
            pageImageView.heightAnchor.constraint(equalTo: topImageContainerView.heightAnchor, multiplier: 0.7),
            
            descriptionTextView.topAnchor.constraint(equalTo: topImageContainerView.bottomAnchor, constant: -40),
            descriptionTextView.leftAnchor.constraint(equalTo: leftAnchor, constant: 24),
            descriptionTextView.rightAnchor.constraint(equalTo: rightAnchor, constant: -24),
            descriptionTextView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
