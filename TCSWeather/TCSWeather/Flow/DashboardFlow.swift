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
import SwinjectAutoregistration

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
    
    private let container = Container() { container in
        container.autoregister(WeatherRequestType.self, argument: String.self, initializer: ioByCity.init)
        container.register(WeatherRequestType.self) { _, lat, lon in
            ioByGeo(lat: lat, lon: lon)
        }
    }
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? WeatherStep else { return FlowContributors.none }
        switch step {
        case .selectInputType:
            return navigationToSelectInputTypeScreen()
        case .inputCity:
            return navigationToInputCityScreen()
        case .inputGeo:
            return navigationToInputGeoScreen()
        case let .showWeatherCity(name):
            return navigationToShowWeatherScreen(name: name)
        case let .showWeatherGeo(lat,lon):
            return navigationToShowWeatherScreen(lat: lat, lon: lon)
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
    
    private func navigationToShowWeatherScreen(name: String) -> FlowContributors {
        let viewModel = ShowWeatherViewModel(ioApi: container ~> (WeatherRequestType.self, argument: name))
        let vc = ShowWatherViewController(viewModel: viewModel)
        UIView.transition(with: (rootViewController.view)!, duration: 0.75, options: .transitionFlipFromRight, animations: {
            self.rootViewController.pushViewController(vc, animated: false)
        })
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: vc))
    }

    private func navigationToShowWeatherScreen(lat: String, lon: String) -> FlowContributors {
        let viewModel = ShowWeatherViewModel(ioApi: container ~> (WeatherRequestType.self, arguments: (lat, lon)))
        let vc = ShowWatherViewController(viewModel: viewModel)
        UIView.transition(with: (rootViewController.view)!, duration: 0.75, options: .transitionFlipFromRight, animations: {
            self.rootViewController.pushViewController(vc, animated: false)
        })
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: vc))
    }
}
