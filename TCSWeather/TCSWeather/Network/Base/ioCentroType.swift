//
//  ioCentroType.swift
//  TCSWeather
//
//  Created by Yevhen Don on 08/03/2019.
//  Copyright © 2019 Yevhen Don. All rights reserved.
//

import Foundation
import Result
import RxSwift

protocol ioCentroType {
    func request<U: Decodable>(endpoint: ioService, subject: PublishSubject<Result<U, ioError>>)
    func request<U: Decodable>(endpoint: ioService, subject: PublishSubject<Result<[U], ioError>>)
}
