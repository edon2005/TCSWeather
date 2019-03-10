//
//  OnboardingFlow.swift
//  TCSWeather
//
//  Created by Yevhen Don on 08/03/2019.
//  Copyright © 2019 Yevhen Don. All rights reserved.
//

import Foundation
import RxFlow

class OnboardFlow: Flow {
    
    var root: Presentable {
        return rootViewController
    }
    
    private lazy var rootViewController: UINavigationController = {
        let viewController = UINavigationController()
        viewController.setNavigationBarHidden(true, animated: false)
        return viewController
    }()
    
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? WeatherStep else { return FlowContributors.none }
        switch step {
        case .splashScreen:
            return navigationToSplashScreen()
        case .splashScreenComplete:
            return .end(forwardToParentFlowWithStep: WeatherStep.onboardingComplete)
        default:
            return FlowContributors.none
        }
    }
    
    private func navigationToSplashScreen() -> FlowContributors {
        let splashViewController = SplashViewController()
        rootViewController.pushViewController(splashViewController, animated: false)
        return .one(flowContributor: .contribute(withNextPresentable: splashViewController, withNextStepper: splashViewController))
    }    
}
