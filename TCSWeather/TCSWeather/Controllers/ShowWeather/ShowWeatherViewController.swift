//
//  ShowWeatherViewController.swift
//  TCSWeather
//
//  Created by Yevhen Don on 10/03/2019.
//  Copyright © 2019 Yevhen Don. All rights reserved.
//

import Foundation
import UIKit

class ShowWatherViewController: BaseViewController<ShowWeatherView> {
    
    private let viewModel: ShowWeatherViewModel
    
    init(viewModel: ShowWeatherViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBinding()
        setupView()
        viewModel.request()
    }
    
    private func setupView() {
        myView.backButton.setTitle("Back", for: .normal)
    }
    
    private func setupBinding() {
        viewModel.source
            .filter { $0 != nil}
            .map { $0! }
            .subscribe(onNext: { [unowned self] in
                print ($0)
                self.myView.cityLabel.text = ("In " + $0.name  + "\ntemperature now")
                self.myView.temperatureLabel.text = String (format: "%.1f", $0.main.temp) + Constants.unit.short
        }).disposed(by: rx.disposeBag)
        
        viewModel.error
            .filter { $0 != nil }
            .map { $0! }
            .subscribe(onNext: { [unowned self] in
                print ($0)
                self.myView.cityLabel.text = "Can't find weather for entered data "
            }).disposed(by: rx.disposeBag)

        myView.backButton
            .rx
            .tap
            .bind(onNext: {[unowned self] in
                UIView.transition(with: (self.navigationController?.view)!, duration: 0.75, options: .transitionFlipFromLeft, animations: {
                    self.navigationController?.popViewController(animated: false)
                })
            })
            .disposed(by: rx.disposeBag)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
