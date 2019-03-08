//
//  ioRequestAccess.swift
//  TCSWeather
//
//  Created by Yevhen Don on 08/03/2019.
//  Copyright © 2019 Yevhen Don. All rights reserved.
//

import Foundation
import Moya
import RxSwift
import Result

protocol ioRequestAccess {
    associatedtype Transform
    var endpoint: ioService {get}
    var map: (Response) throws -> Transform {get}
    var subject: PublishSubject<Result<Transform, ioError>>? {get}
}
