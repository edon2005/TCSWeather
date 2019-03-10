//
//  SelectInputTypeViewController.swift
//  TCSWeather
//
//  Created by Yevhen Don on 09/03/2019.
//  Copyright © 2019 Yevhen Don. All rights reserved.
//

import Foundation
import UIKit
import EasyPeasy
import RxSwift
import NSObject_Rx

class SelectInputTypeViewController: BaseViewController<SelectInputTypeView> {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupBinding()
    }

    private func setupView() {
        myView.cityButton.setTitle("By City Name", for: .normal)
        myView.geoPositionButton.setTitle("By Geo Position", for: .normal)
    }
    
    private func setupBinding() {
        myView.cityButton
            .rx
            .tap
            .bind(onNext: {[unowned self] in
                self.steps.accept(WeatherStep.inputCity)
            })
            .disposed(by: rx.disposeBag)
        
        myView.geoPositionButton
            .rx
            .tap
            .bind(onNext: {[unowned self] in
                self.steps.accept(WeatherStep.inputGeo)
            })
            .disposed(by: rx.disposeBag)

    }
}
