//
//  ViewControllerFactory.swift
//  ImpulseTest
//
//  Created by Diana on 11.09.2022.
//

import Foundation
import UIKit

enum TypeOfViewController {
    case onboardingVC
    case timerVC
}

extension TypeOfViewController {
    func getViewController() -> UIViewController {
        switch self {
        case .onboardingVC:
            return OnboardingViewController()
        case .timerVC:
            return TimerViewController()
        }
    }
}

class ViewControllerFactory: NSObject {
    static func viewController(for typeOfVC: TypeOfViewController) -> UIViewController {
        let vc = typeOfVC.getViewController()
        vc.modalPresentationStyle = .custom
        vc.modalTransitionStyle = .crossDissolve
        return vc
    }
}
