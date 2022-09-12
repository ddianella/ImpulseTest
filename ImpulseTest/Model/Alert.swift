//
//  Alert.swift
//  ImpulseTest
//
//  Created by Diana on 11.09.2022.
//
import UIKit

struct Alert {
    static func present(title: String?, message: String, from controller: UIViewController) {
        let darkView = UIView()
        darkView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        darkView.frame = controller.view.frame
        controller.view.addSubview(darkView)
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.setTitle(font: UIFont.boldSystemFont(ofSize: 16), color: .secondarySystemBackground)
        alertController.setMessage(font: UIFont.systemFont(ofSize: 12), color: .secondarySystemBackground)
        alertController.setBackgroundColor(color: .mainBackgroundColor)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            darkView.removeFromSuperview()
        }
        alertController.addAction(okAction)
        controller.present(alertController, animated: true, completion: nil)
    }
}
