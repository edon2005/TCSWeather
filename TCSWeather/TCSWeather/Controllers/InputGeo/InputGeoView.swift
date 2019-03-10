//
//  InputGeoView.swift
//  TCSWeather
//
//  Created by Yevhen Don on 09/03/2019.
//  Copyright © 2019 Yevhen Don. All rights reserved.
//

import Foundation
import UIKit
import EasyPeasy

class InputGeoView: InputBaseView {
    let searchByPositionTitle = UILabel()
    let latitudeTextField = UITextField()
    let longitueTextField = UITextField()
    
    override func setupView() {
        super.setupView()
        let rectangle = UIView()
        [rectangle, searchByPositionTitle].forEach(middleView.addSubview)
        [latitudeTextField, longitueTextField].forEach(rectangle.addSubview)
        
        rectangle.easy.layout(Top(6), Bottom(), Left(), Right())
        searchByPositionTitle.easy.layout(Top(), Left(10))
        latitudeTextField.easy.layout(Top(12), Left(8), Height(55), Right(8))
        longitueTextField.easy.layout(Bottom(12), Left(8), Right(8), Height().like(latitudeTextField))
        middleView.easy.layout(CenterX(), Height(150), Width(*0.75).like(contentView))
        
        rectangle.layer.cornerRadius = 4
        rectangle.layer.borderWidth = 1
        rectangle.layer.borderColor = UIColor.customLightGray.cgColor
        
        [rectangle].forEach { $0.backgroundColor = .clear }
        searchByPositionTitle.backgroundColor = .white
        searchByPositionTitle.font = UIFont.systemFont(ofSize: 12)
        searchByPositionTitle.textColor = .customLightGray
        
        [latitudeTextField, longitueTextField].forEach {
            $0.font = UIFont.systemFont(ofSize: 14)
            $0.backgroundColor = UIColor.customLightGray.withAlphaComponent(0.1)
            $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 2))
            $0.leftViewMode = .always
            $0.textColor = .gray
        }
    }
}
