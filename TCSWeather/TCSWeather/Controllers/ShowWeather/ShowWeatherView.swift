//
//  ShowWeatherView.swift
//  TCSWeather
//
//  Created by Yevhen Don on 10/03/2019.
//  Copyright © 2019 Yevhen Don. All rights reserved.
//

import Foundation
import UIKit

class ShowWeatherView: BaseView {
    let cityLabel = UILabel()
    let temperatureLabel = UILabel()

    override func setupView() {
        [cityLabel, temperatureLabel].forEach(addSubview)
        
    }
}
