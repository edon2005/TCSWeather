//
//  WeatherStep.swift
//  TCSWeather
//
//  Created by Yevhen Don on 08/03/2019.
//  Copyright © 2019 Yevhen Don. All rights reserved.
//

import RxFlow

enum WeatherStep: Step {
    case onboarding
    case onboardingComplete
    
    case splashScreen
    case splashScreenComplete
    
    case dashboard
    
    case selectInputType
    case inputCity
    case inputGeo
    case showWeatherCity
    case showWeatherGeo
}
