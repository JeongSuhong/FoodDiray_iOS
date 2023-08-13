//
//  OnboardingFlow.swift
//  FoodDiary
//
//  Created by JeongSuhong on 2023/08/13.
//

import Foundation
import UIKit
import RxFlow

// MARK: - Step

enum OnboardingStep: Step {
case main
}

// MARK: - Flow

final class OnboardingFlow: Flow {
  
  var root: Presentable {
    return rootViewController
  }
  
  private let rootViewController: UINavigationController
  
  init() {
    self.rootViewController = UINavigationController()
  }
    
  func navigate(to step: Step) -> FlowContributors {
    guard let step = step as? OnboardingStep else { return .none }
    switch step {
    case .main:
        let vc = UIViewController.make(ofType: LoginViewController.self)
        let reactor = LoginViewControllerReactor()
        vc.reactor = reactor
        rootViewController.setViewControllers([vc], animated: false)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: reactor))
    }
  }
}
