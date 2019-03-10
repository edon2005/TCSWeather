//
//  SelectInputType.swift
//  TCSWeather
//
//  Created by Yevhen Don on 09/03/2019.
//  Copyright © 2019 Yevhen Don. All rights reserved.
//

import Foundation
import UIKit
import EasyPeasy

class SelectInputTypeView: BaseView {
    
    let cityButton = UIButton()
    let geoPositionButton = UIButton()
    
    override func setupView() {
        [cityButton, geoPositionButton].forEach(addSubview)

        cityButton.easy.layout(Width(*0.65).like(self), Height(70), CenterX(), CenterY(-(70*2)))
        geoPositionButton.easy.layout(Width().like(cityButton), Height().like(cityButton), CenterX(), Top(100).to(cityButton))
        
        backgroundColor = .white
        
        [cityButton, geoPositionButton].forEach {
            $0.backgroundColor = UIColor.blue.withAlphaComponent(0.5)
            $0.layer.shadowOpacity = 0.5
            $0.layer.shadowRadius = 30
            $0.layer.shadowOffset = CGSize(width: 0, height: 15)
            $0.layer.shadowColor = UIColor.black.cgColor
            $0.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .regular)
            $0.layer.cornerRadius = 4
        }
    }
}
