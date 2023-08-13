//
//  AppFlow.swift
//  FoodDiary
//
//  Created by JeongSuhong on 2023/08/13.
//

import Foundation
import UIKit
import RxFlow
import RxSwift
import RxCocoa

// MARK: - Step

enum AppStep: Step {
    case splash
case login
}

// MARK: - Flow

final class AppFlow: Flow {
    
    var root: Presentable {
        return rootViewController
    }
    
    private let window: UIWindow
    private var rootViewController: UIViewController
    
    init(window: UIWindow) {
        self.rootViewController = UIStoryboard(name: "LaunchScreen", bundle: nil).instantiateInitialViewController()!
        self.window = window
    }
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? AppStep else { return .none }
        switch step {
        case .splash:
            let vc = UIStoryboard(name: "LaunchScreen", bundle: nil).instantiateInitialViewController()!
            self.window.rootViewController = vc
            self.rootViewController = vc
            return .none
            
        case .login:
            let flow = OnboardingFlow()
            Flows.use(flow, when: .ready) { [unowned self] vc in
                self.window.rootViewController = vc
                self.rootViewController = vc
            }
            return .one(flowContributor: .contribute(
                withNextPresentable: flow,
                withNextStepper: OneStepper(withSingleStep: OnboardingStep.main)))
        }
    }
}

// MARK: - Stepper

final class AppStepper: Stepper {
    
    let steps = PublishRelay<Step>()
    private var disposeBag = DisposeBag()

    var initialStep: Step {
        return AppStep.login
    }
    
    func readyToEmitSteps() {
        Observable.just(())
            .delay(.seconds(1), scheduler: MainScheduler.instance)
            .bind(with: self) { stepper, _ in
                // Check Login
                stepper.steps.accept(AppStep.login)
            }.disposed(by: disposeBag)
    }
}

