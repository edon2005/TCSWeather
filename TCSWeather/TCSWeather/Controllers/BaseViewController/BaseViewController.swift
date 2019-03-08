//
//  BaseViewController.swift
//  TCSWeather
//
//  Created by Yevhen Don on 08/03/2019.
//  Copyright © 2019 Yevhen Don. All rights reserved.
//

import Foundation
import RxFlow
import RxCocoa

class BaseViewController<T: BaseView>: UIViewController, Stepper {
    let steps = PublishRelay<Step>()
    
    var myView = T()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        print("🆕 \(type(of: self)): \(#function)")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = myView
        myView.setupView()
    }
    
    deinit {
        print("🏁 \(type(of: self)): \(#function)")
    }
}
