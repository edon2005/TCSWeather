//
//  WeatherRequestType.swift
//  TCSWeather
//
//  Created by Yevhen Don on 10/03/2019.
//  Copyright © 2019 Yevhen Don. All rights reserved.
//

import Foundation
import RxSwift
import Result

protocol WeatherRequestType {
    func proceed(_ response: PublishSubject<Result<ModelWeather, ioError>>)
}
