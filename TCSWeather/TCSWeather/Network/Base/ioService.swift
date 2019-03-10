//
//  ioService.swift
//  TCSWeather
//
//  Created by Yevhen Don on 08/03/2019.
//  Copyright © 2019 Yevhen Don. All rights reserved.
//

import Foundation

import Moya

public enum AdditionalParameterType {
    case none
    case need
}

enum ioService {
    case currentWeatherByCity(String)
    case currentWeatherByGeo(String, String)
    case searchCity(String)
}

// MARK: - TargetType Protocol Implementation
extension ioService: TargetType {
    
    var baseURL: URL {
        guard let url = URL(string: Constants.baseAddr) else { fatalError("Constants.baseAddr wrong") }
        return url
    }
    
    var path: String {
        switch self {
        case .currentWeatherByCity:
            return "/weather"
        case .currentWeatherByGeo:
            return "/weather"
        case .searchCity:
            return "/find"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .currentWeatherByCity, .currentWeatherByGeo, .searchCity:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case let .currentWeatherByCity(cityName):
            return .requestCompositeParameters(bodyParameters: [:], bodyEncoding: URLEncoding.httpBody, urlParameters: ["q":cityName])
        case let .currentWeatherByGeo(lat, lon):
            return .requestCompositeParameters(bodyParameters: [:], bodyEncoding: URLEncoding.httpBody, urlParameters: ["lat":lat, "lon":lon])
        case let .searchCity(cityName):
            return .requestCompositeParameters(bodyParameters: [:], bodyEncoding: URLEncoding.httpBody, urlParameters: ["q":cityName])
        }
    }
    
    var sampleData: Data {
        switch self {
        default:
            return "".utf8Encoded;
        }
    }
    
    var headers: [String: String]? {
        return nil
    }
    
    var authorizationType: AdditionalParameterType {
        switch self {
        case .currentWeatherByCity, .currentWeatherByGeo, .searchCity:
            return .need
        }
    }
}
