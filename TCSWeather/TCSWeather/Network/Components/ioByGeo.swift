//
//  ioByGeo.swift
//  TCSWeather
//
//  Created by Yevhen Don on 10/03/2019.
//  Copyright © 2019 Yevhen Don. All rights reserved.
//

import Foundation
import RxSwift
import Result

class ioByGeo: WeatherRequestType {
    
    private let lat: String
    private let lon: String
    
    init(lat: String, lon: String) {
        self.lat = lat
        self.lon = lon
    }
    
    func proceed(_ response: PublishSubject<Result<ModelWeather, ioError>>) {
        ioCentro().request(endpoint: .currentWeatherByGeo(lat, lon), subject: response)
    }
}
