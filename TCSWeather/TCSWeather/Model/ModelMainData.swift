//
//  ModelMainData.swift
//  TCSWeather
//
//  Created by Yevhen Don on 10/03/2019.
//  Copyright © 2019 Yevhen Don. All rights reserved.
//

import Foundation
import Mapper

//part of model getting from openweather
struct MainData {
    var temp: Double
    var pressure: Double
    var humidity: Double
    var temp_min: Double
    var temp_max: Double
}

//custom mapping
extension MainData: Convertible {
    static func fromMap(_ value: Any) throws -> MainData {
        guard let data = value as? NSDictionary,
            let temp = data["temp"] as? Double,
            let pressure = data["pressure"] as? Double,
            let humidity = data["humidity"] as? Double,
            let temp_min = data["temp_min"] as? Double,
            let temp_max = data["temp_max"] as? Double else
        {
            throw MapperError.convertibleError(value: value, type: [String: Double].self)
        }
        return MainData(temp: temp, pressure: pressure, humidity: humidity, temp_min: temp_min, temp_max: temp_max)
    }
}

