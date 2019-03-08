//
//  ioCentro.swift
//  TCSWeather
//
//  Created by Yevhen Don on 08/03/2019.
//  Copyright © 2019 Yevhen Don. All rights reserved.
//

import Foundation
import RxSwift
import Moya
import Result
import Mapper

//class to send request and
class ioCentro {
    private struct Request<U>: ioRequestAccess {
        typealias Transform = U
        var endpoint: ioService
        var map: (Response) throws -> Transform
        weak var subject: PublishSubject<Result<Transform, ioError>>?
    }
}

extension ioCentro {
    func request<U: Mappable>(endpoint: ioService, subject: PublishSubject<Result<U, ioError>>) {
        let r = Request<U>(endpoint: endpoint, map: ioTransform.map, subject: subject)
        ioBase().request(r)
    }
    
    func request<U: Mappable>(endpoint: ioService, subject: PublishSubject<Result<[U], ioError>>) {
        let r = Request<[U]>(endpoint: endpoint, map: ioTransform.map, subject: subject)
        ioBase().request(r)
    }
}
