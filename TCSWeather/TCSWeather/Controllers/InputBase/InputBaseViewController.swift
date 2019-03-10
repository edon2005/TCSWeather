//
//  InputBaseViewController.swift
//  TCSWeather
//
//  Created by Yevhen Don on 10/03/2019.
//  Copyright © 2019 Yevhen Don. All rights reserved.
//

import Foundation
import UIKit

class InputBaseViewController<T: InputBaseView>: BaseViewController<T> {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupBinding()
    }
    
    func setupView() {
        myView.scrollView.isScrollEnabled = false
        myView.backButton.setTitle("Back", for: .normal)
        myView.searchButton.setTitle("Search", for: .normal)
    }
    
    private func setupBinding() {
        myView.backButton
            .rx
            .tap
            .bind(onNext: {[unowned self] in
                UIView.transition(with: (self.navigationController?.view)!, duration: 0.75, options: .transitionFlipFromLeft, animations: {
                    self.navigationController?.popViewController(animated: false)
                })
            })
            .disposed(by: rx.disposeBag)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.async {
            UIView.animate(withDuration: 1, animations: {
                self.myView.middleView.alpha = 1
            }, completion: { _ in
                UIView.animate(withDuration: 0.3, animations: {
                    self.myView.backButton.alpha = 1
                }, completion: { _ in
                    UIView.animate(withDuration: 0.3) {
                        self.myView.searchButton.alpha = 1
                    }
                })
            })
        }
    }
}
