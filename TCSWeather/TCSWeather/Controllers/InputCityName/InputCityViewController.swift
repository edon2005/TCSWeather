//
//  MainViewController.swift
//  TCSWeather
//
//  Created by Yevhen Don on 08/03/2019.
//  Copyright © 2019 Yevhen Don. All rights reserved.
//

import Foundation
import UIKit
import EasyPeasy
import RxSwift
import RxCocoa
import NSObject_Rx

class InputCityViewController: InputBaseViewController<InputCityView>, UITextFieldDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupBinding()
    }
    
    override func setupView() {
        super.setupView()
        myView.searchByCityTitle.text = " Search Weather by City Name "
        myView.cityTextField.placeholder = "input city name here..."
    }
    
    private func setupBinding() {
        myView.cityTextField
            .rx
            .controlEvent(.editingDidEndOnExit)
            .bind(onNext: {[unowned self] in
                self.view.endEditing(true)
            })
            .disposed(by: rx.disposeBag)
        
        myView.searchButton
            .rx
            .tap
            .bind(onNext: {[unowned self] in
                guard let name = self.myView.cityTextField.text else { return }
                self.steps.accept(WeatherStep.showWeatherCity(name: name.trimmingCharacters(in: .whitespaces)))
            })
            .disposed(by: rx.disposeBag)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.myView.middleView.easy.layout(Top(self.myView.bounds.height/2 - 75 - 50))
        self.myView.scrollView.layoutIfNeeded()
        super.viewDidAppear(animated)
    }
}
