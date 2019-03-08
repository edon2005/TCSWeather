//
//  Units.swift
//  TCSWeather
//
//  Created by Yevhen Don on 08/03/2019.
//  Copyright © 2019 Yevhen Don. All rights reserved.
//

//Units using in request to openweather.
enum Units: String {
    case kelvin
    case metric
    case imperial
    
    var short: String {
        switch self {
        case .kelvin:
            return "K"
        case .metric:
            return "C"
        case .imperial:
            return "F"
        }
    }
}
