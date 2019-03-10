//
//  ioByCity.swift
//  TCSWeather
//
//  Created by Yevhen Don on 10/03/2019.
//  Copyright © 2019 Yevhen Don. All rights reserved.
//

import Foundation
import RxSwift
import Result

class ioByCity: WeatherRequestType {
    
    private let cityName: String
    
    init(cityName: String) {
        self.cityName = cityName
    }
    
    func proceed(_ response: PublishSubject<Result<ModelWeather, ioError>>) {
        ioCentro().request(endpoint: .currentWeatherByCity(cityName), subject: response)
    }
}
