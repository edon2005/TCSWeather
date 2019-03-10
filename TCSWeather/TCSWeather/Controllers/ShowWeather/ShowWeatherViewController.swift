//
//  ShowWeatherViewController.swift
//  TCSWeather
//
//  Created by Yevhen Don on 10/03/2019.
//  Copyright © 2019 Yevhen Don. All rights reserved.
//

import Foundation

class ShowWatherViewController: BaseViewController<ShowWeatherView> {
    
    private let viewModel: ShowWeatherViewModel
    
    init(viewModel: ShowWeatherViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.request()
    }
    
    private func setupBinding() {
        viewModel.source.subscribe(onNext: {
            print ($0)
        }).disposed(by: rx.disposeBag)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
