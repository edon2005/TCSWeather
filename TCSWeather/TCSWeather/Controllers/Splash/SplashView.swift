//
//  SplashView.swift
//  TCSWeather
//
//  Created by Yevhen Don on 08/03/2019.
//  Copyright © 2019 Yevhen Don. All rights reserved.
//

import UIKit
import EasyPeasy

class SplashView: BaseView {
    
    var topView = UIView()
    var middleView = UIView()
    var bottomView = UIView()
    var label = UILabel()

    override func setupView() {
        //add Views and setup constraints
        [topView, middleView, bottomView].forEach(addSubview)
        
        middleView.easy.layout(Left().to(self, .right), CenterY(), Height(*0.33).like(self), Width().like(self))
        topView.easy.layout(Right().to(self, .left), Bottom().to(middleView, .top).with(.low), Size().like(middleView))
        bottomView.easy.layout(Right().to(self, .left), Top().to(middleView).with(.low), Size().like(topView))
        
        [label].forEach(middleView.addSubview)
        label.easy.layout(CenterY().with(.low), CenterX())
        label.font = UIFont(name: "Futura", size: 36)

        topView.backgroundColor = .customYellow
        middleView.backgroundColor = .customWhite
        bottomView.backgroundColor = .customRed
        label.textColor = UIColor(displayP3Red: 231/255, green: 76/255, blue: 60/255, alpha: 1)
    }

}
