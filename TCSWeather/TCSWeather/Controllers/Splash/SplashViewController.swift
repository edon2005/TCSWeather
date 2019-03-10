//
//  SplashViewController.swift
//  TCSWeather
//
//  Created by Yevhen Don on 08/03/2019.
//  Copyright © 2019 Yevhen Don. All rights reserved.
//

import Foundation
import Foundation
import EasyPeasy
import RxSwift
import Result
import NSObject_Rx
import RxFlow

class SplashViewController: BaseViewController<SplashView> {

    override func viewDidLoad() {
        super.viewDidLoad()
        myView.label.text = Constants.appName
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //make animations on main VC
        UIView.animate(withDuration: 1,
                       delay: 0,
                       usingSpringWithDamping: 0.9,
                       initialSpringVelocity: 0.1,
                       options: [.curveEaseIn],
                       animations: { [unowned self] in
                        self.myView.topView.easy.layout(Right())
                        self.myView.bottomView.easy.layout(Right())
                        self.myView.middleView.easy.layout(Left())
                        self.myView.layoutIfNeeded()
            }, completion: { _ in
                UIView.animate(withDuration: 1, animations: {
                    self.myView.middleView.easy.layout(Size().like(self.view))
                    self.myView.label.easy.layout(Top(50))
                    self.myView.layoutIfNeeded()
                }, completion: { _ in
                    self.steps.accept(WeatherStep.splashScreenComplete)
                })
        })
    }
}
