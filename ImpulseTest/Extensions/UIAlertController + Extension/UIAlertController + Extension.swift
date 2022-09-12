//
//  UIAlertController + Extension.swift
//  ImpulseTest
//
//  Created by Diana on 10.09.2022.
//

import UIKit

extension UIAlertController {
    func setBackgroundColor(color: UIColor) {
        if let backgroundView = self.view.subviews.first,
           let groupView = backgroundView.subviews.first,
           let contentView = groupView.subviews.first {
            contentView.backgroundColor = color
        }
    }
    
    func setTitle(font: UIFont?, color: UIColor?) {
        guard let title = self.title else { return }
        let attributeString = NSMutableAttributedString(string: title)
        if let titleFont = font {
            attributeString.addAttributes([NSAttributedString.Key.font : titleFont],
                                          range: NSMakeRange(0, title.utf8.count))
        }
        if let titleColor = color {
            attributeString.addAttributes([NSAttributedString.Key.foregroundColor : titleColor],
                                          range: NSMakeRange(0, title.utf8.count))
        }
        self.setValue(attributeString, forKey: "attributedTitle")
    }
    
    func setMessage(font: UIFont?, color: UIColor?) {
        guard let message = self.message else {
            return
        }
        let attributedString = NSMutableAttributedString(string: message)
        if let messageFont = font {
            attributedString.addAttributes([NSAttributedString.Key.font : messageFont], range: NSMakeRange(0, message.utf8.count))
        }
        if let messageColor = color {
            attributedString.addAttributes([NSAttributedString.Key.foregroundColor : messageColor], range: NSMakeRange(0, message.utf8.count))
        }
        self.setValue(attributedString, forKey: "attributedMessage")
    }
    
}
