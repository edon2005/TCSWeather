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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHideKeyboard()
    }
    
    func setupHideKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyboard))
        
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    deinit {
        print("🏁 \(type(of: self)): \(#function)")
    }
}
