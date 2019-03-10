//
//  InputBaseView.swift
//  TCSWeather
//
//  Created by Yevhen Don on 10/03/2019.
//  Copyright © 2019 Yevhen Don. All rights reserved.
//

import Foundation
import UIKit
import EasyPeasy

class InputBaseView: BaseView {
    let scrollView = UIScrollView()
    let contentView = UIView()
    let middleView = UIView()
    let backButton = UIButton()
    let searchButton = UIButton()
    
    override func setupView() {
        [scrollView].forEach(addSubview)
        [contentView].forEach(scrollView.addSubview)
        [middleView, backButton, searchButton].forEach(contentView.addSubview)
        
        scrollView.easy.layout(Edges())
        contentView.easy.layout(Edges(), Width().like(scrollView), Height().like(scrollView))
        
        backButton.easy.layout(Top(100).to(middleView), Left().to(middleView, .left), Height(50), Width(*0.4).like(middleView))
        searchButton.easy.layout(Top().to(backButton, .top), Right().to(middleView, .right), Size().like(backButton))
        
        
        [middleView].forEach { $0.backgroundColor = .clear }
        UITextField.appearance().tintColor = UIColor.lightGray
        backgroundColor = .white
        
        [backButton, searchButton].forEach {
            $0.backgroundColor = UIColor.blue.withAlphaComponent(0.5)
            $0.layer.cornerRadius = 4
            $0.layer.shadowOpacity = 1
            $0.layer.shadowRadius = 30
            $0.layer.shadowOffset = CGSize(width: 0, height: 15)
            $0.layer.shadowColor = UIColor.blue.withAlphaComponent(0.5).cgColor
            $0.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .regular)
            $0.alpha = 0
        }
        middleView.alpha = 0
    }
}
