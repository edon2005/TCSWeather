//
//  MainView.swift
//  TCSWeather
//
//  Created by Yevhen Don on 08/03/2019.
//  Copyright © 2019 Yevhen Don. All rights reserved.
//

import UIKit
import EasyPeasy

class InputCityView: InputBaseView {
        
    let searchByCityTitle = UILabel()
    let cityTextField = UITextField()
    
    override func setupView() {
        super.setupView()
        let rectangle = UIView()
        [rectangle, searchByCityTitle].forEach(middleView.addSubview)
        rectangle.addSubview(cityTextField)
            
        rectangle.easy.layout(Top(6), Bottom(), Left(), Right())
        searchByCityTitle.easy.layout(Top(), Left(10))
        cityTextField.easy.layout(Top(12), Bottom(12), Left(8), Right(8))
        middleView.easy.layout(CenterX(), Height(74), Width(*0.75).like(contentView))
            
        rectangle.layer.cornerRadius = 4
        rectangle.layer.borderWidth = 1
        rectangle.layer.borderColor = UIColor.customLightGray.cgColor
        
        [rectangle].forEach { $0.backgroundColor = .clear }
        searchByCityTitle.backgroundColor = .white
        searchByCityTitle.font = UIFont.systemFont(ofSize: 12)
        searchByCityTitle.textColor = .customLightGray
        
        cityTextField.font = UIFont.systemFont(ofSize: 14)
        cityTextField.backgroundColor = UIColor.customLightGray.withAlphaComponent(0.1)
        cityTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 2))
        cityTextField.leftViewMode = .always
        cityTextField.textColor = UIColor.gray
    }
}
