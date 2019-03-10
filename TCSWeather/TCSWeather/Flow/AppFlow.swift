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
    
    private let rootWindow: UIWindow

    init(withWindow window: UIWindow) {
        rootWindow = window
    }
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? WeatherStep else { return FlowContributors.none }
        
        switch step {
        case .onboarding:
            return navigationToOnboardingScreen()
        case .splashScreenComplete: fallthrough
        case .onboardingComplete:
            return navigateToDashboard()
        default:
            return FlowContributors.none
        }
    }
}

extension AppFlow {
    var root: Presentable {
        return self.rootWindow
    }

    private func navigationToOnboardingScreen () -> FlowContributors {
        let splashFlow = OnboardFlow()
        Flows.whenReady(flow1: splashFlow) { [unowned self] (root) in
            self.rootWindow.rootViewController = root
        }
        return FlowContributors.one(flowContributor: .contribute(withNextPresentable: splashFlow, withNextStepper: OneStepper(withSingleStep: WeatherStep.splashScreen)))
    }
    
    private func navigateToDashboard() -> FlowContributors {
        let dashboardFlow = DashboardFlow()
        Flows.whenReady(flow1: dashboardFlow) {[unowned self] root in
            DispatchQueue.main.async {
                self.animateTransition(to: root)
            }
        }
        return FlowContributors.one(flowContributor: .contribute(withNextPresentable: dashboardFlow, withNextStepper: OneStepper(withSingleStep: WeatherStep.selectInputType)))
    }
}

extension AppFlow {
    private func animateTransition(to root: UIViewController, options: UIView.AnimationOptions = [UIView.AnimationOptions.transitionCrossDissolve] ) {
        UIView.transition(from: rootWindow.rootViewController!.view, to: root.view, duration: 0.5, options: options){_ in
            self.rootWindow.rootViewController = root
        }
    }
}
