//
//  AppFlow.swift
//  TCSWeather
//
//  Created by Yevhen Don on 08/03/2019.
//  Copyright © 2019 Yevhen Don. All rights reserved.
//

import Foundation
import RxFlow
import Swinject

class AppFlow: Flow {
    
    var root: Presentable {
        return rootViewController
    }
    
    private lazy var rootViewController: UINavigationController = {
        let viewController = UINavigationController()
        viewController.setNavigationBarHidden(true, animated: false)
        return viewController
    }()
    
    init() {
    }
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? WeatherStep else { return FlowContributors.none }
        
        switch step {
        case .onboarding:
            return navigationToOnboardingScreen()
        case .splashScreenComplete: fallthrough
        case .onboardingComplete:fallthrough

        default:
            return FlowContributors.none
        }
    }
    
    private func navigationToOnboardingScreen () -> FlowContributors {
        let onboardingFlow = SplashFlow()
        Flows.whenReady(flow1: onboardingFlow) { [unowned self] (root) in
            DispatchQueue.main.async {
                self.rootViewController.present(root, animated: true)
            }
        }
        return FlowContributors.one(flowContributor: .contribute(withNextPresentable: onboardingFlow, withNextStepper: OneStepper(withSingleStep: WeatherStep.splashScreen)))
    }
}
