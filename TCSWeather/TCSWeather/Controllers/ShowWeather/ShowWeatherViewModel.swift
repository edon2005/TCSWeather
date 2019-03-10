//
//  ShowWeatherViewModel.swift
//  TCSWeather
//
//  Created by Yevhen Don on 10/03/2019.
//  Copyright © 2019 Yevhen Don. All rights reserved.
//

import Foundation
import Result
import RxSwift
import RxCocoa

class ShowWeatherViewModel: NSObject {
    
    private let weatherRequest: WeatherRequestType
    private let response = PublishSubject<Result<ModelWeather, ioError>>()
    
    let source = BehaviorRelay<ModelWeather?>(value: nil)
    let error = BehaviorRelay<ioError?>(value: nil)

    init(ioApi: WeatherRequestType) {
        weatherRequest = ioApi
        super.init()
        setupBinding()
    }
    
    private func setupBinding() {
        response
            .map { try $0.get() }
            .subscribe(
                onNext: { [weak self] result in
                    print ("✅ Ok")
                    self?.source.accept(result)
                },
                onError: {[weak self] error in
                    let error = error as! ioError
                    print ("❌ Error")
                    self?.error.accept(error)
            })
            .disposed(by: rx.disposeBag)
    }
    
    func request() {
        weatherRequest.proceed(response)
    }
}
