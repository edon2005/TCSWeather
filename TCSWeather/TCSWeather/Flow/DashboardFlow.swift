//
//  DashboardFlow.swift
//  TCSWeather
//
//  Created by Yevhen Don on 09/03/2019.
//  Copyright © 2019 Yevhen Don. All rights reserved.
//

import Foundation
import RxFlow
import EasyPeasy
import Swinject

class DashboardFlow: Flow {
    var root: Presentable {
        return containerVC
    }
    
    private lazy var containerVC = ContainerViewController(vc: rootViewController)
    
    private lazy var rootViewController: UINavigationController = {
        let viewController = UINavigationController()
        viewController.setNavigationBarHidden(true, animated: false)
        return viewController
    }()
    
    private let container:
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? WeatherStep else { return FlowContributors.none }
        switch step {
        case .selectInputType:
            return navigationToSelectInputTypeScreen()
        case .inputCity:
            return navigationToInputCityScreen()
        case .inputGeo:
            return navigationToInputGeoScreen()
        default:
            return FlowContributors.none
        }
    }
    
    private func navigationToSelectInputTypeScreen() -> FlowContributors {
        let vc = SelectInputTypeViewController()
        rootViewController.pushViewController(vc, animated: false)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: vc))
    }
    
    private func navigationToInputCityScreen() -> FlowContributors {
        let vc = InputCityViewController()
        UIView.transition(with: (rootViewController.view)!, duration: 0.75, options: .transitionFlipFromRight, animations: {
            self.rootViewController.pushViewController(vc, animated: false)
        })
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: vc))
    }
    
    private func navigationToInputGeoScreen() -> FlowContributors {
        let vc = InputGeoViewController()
        UIView.transition(with: (rootViewController.view)!, duration: 0.75, options: .transitionFlipFromRight, animations: {
            self.rootViewController.pushViewController(vc, animated: false)
        })
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: vc))
    }

}
