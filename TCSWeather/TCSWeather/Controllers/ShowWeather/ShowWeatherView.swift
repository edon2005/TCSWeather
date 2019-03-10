//
//  ShowWeatherView.swift
//  TCSWeather
//
//  Created by Yevhen Don on 10/03/2019.
//  Copyright © 2019 Yevhen Don. All rights reserved.
//

import Foundation
import UIKit
import EasyPeasy

class ShowWeatherView: BaseView {
    let cityLabel = UILabel()
    let temperatureLabel = UILabel()
    let backButton = UIButton()

    override func setupView() {
        [cityLabel, temperatureLabel, backButton].forEach(addSubview)

        cityLabel.easy.layout(Left(5), Right(5), CenterY(-100))
        temperatureLabel.easy.layout(CenterX(), CenterY())
        backButton.easy.layout(Top(100).to(temperatureLabel), CenterX(), Height(50), Width(120))

        cityLabel.numberOfLines = 2
        cityLabel.textAlignment = .center
        cityLabel.adjustsFontSizeToFitWidth = true
        
        [cityLabel, temperatureLabel].forEach {
            $0.textColor = .customBlue
            $0.font = UIFont(name: "Futura", size: 30)
        }

        backButton.backgroundColor = UIColor.blue.withAlphaComponent(0.5)
        backButton.layer.cornerRadius = 4
        backButton.layer.shadowOpacity = 1
        backButton.layer.shadowRadius = 30
        backButton.layer.shadowOffset = CGSize(width: 0, height: 15)
        backButton.layer.shadowColor = UIColor.blue.withAlphaComponent(0.5).cgColor
        backButton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .regular)

    }
}
