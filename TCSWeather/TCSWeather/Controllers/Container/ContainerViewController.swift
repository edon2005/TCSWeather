//
//  ContainerViewController.swift
//  TCSWeather
//
//  Created by Yevhen Don on 09/03/2019.
//  Copyright © 2019 Yevhen Don. All rights reserved.
//

import Foundation
import UIKit
import EasyPeasy

class ContainerViewController: UIViewController {
    
    private var vc: UIViewController
    private let appLabel = UILabel()
    private let line = UIView()

    init(vc: UIViewController) {
        self.vc = vc
        super.init(nibName: nil, bundle: nil)
        print("🆕 \(type(of: self)): \(#function)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupContainer()
    }
    
    private func setupView() {
        [appLabel, line].forEach(view.addSubview)
        appLabel.easy.layout(Top(50), CenterX())
        line.easy.layout(CenterX(), Top(10).to(appLabel), Height(2), Width(0))
        appLabel.font = UIFont(name: "Futura", size: 36)
        appLabel.text = Constants.appName
        appLabel.textColor = .customRed
        
        view.backgroundColor = .white
        line.backgroundColor = .customRed

    }
    
    private func setupContainer() {
        addChild(vc)
        view.addSubview(vc.view)
        vc.view.easy.layout(Top(10).to(line), Left(), Right(), Bottom())
        vc.didMove(toParent: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        line.easy.layout(Width().like(appLabel))
        UIView.animate(withDuration: 1) {
            self.view.layoutIfNeeded()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("🆕 \(type(of: self)): \(#function)")
    }
}
