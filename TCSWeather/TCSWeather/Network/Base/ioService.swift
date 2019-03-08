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
    case currentWeather(String)
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
        case .currentWeather:
            return "/weather"
        case .searchCity:
            return "/find"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .currentWeather, .searchCity:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case let .currentWeather(cityName):
            return .requestCompositeParameters(bodyParameters: [:], bodyEncoding: URLEncoding.httpBody, urlParameters: ["q":cityName])
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
        case .currentWeather, .searchCity:
            return .need
        }
    }
}
