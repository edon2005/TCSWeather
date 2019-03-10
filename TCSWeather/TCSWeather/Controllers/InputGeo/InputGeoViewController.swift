//
//  InputGeoViewController.swift
//  TCSWeather
//
//  Created by Yevhen Don on 09/03/2019.
//  Copyright © 2019 Yevhen Don. All rights reserved.
//

import Foundation
import UIKit
import EasyPeasy

class InputGeoViewController: InputBaseViewController<InputGeoView>, UITextFieldDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupBinding()
    }
    
    override func setupView() {
        super.setupView()
        myView.searchByPositionTitle.text = " Search Weather by Geo Position "
        myView.latitudeTextField.placeholder = "input latitude here..."
        myView.longitueTextField.placeholder = "input longitude here..."
    }
    
    private func setupBinding() {
        myView.latitudeTextField
            .rx
            .controlEvent(.editingDidEndOnExit)
            .bind(onNext: {[unowned self] in
                if self.myView.longitueTextField.text?.count == 0 {
                    self.myView.longitueTextField.becomeFirstResponder()
                } else {
                    self.view.endEditing(true)
                }
            })
            .disposed(by: rx.disposeBag)
        
        myView.longitueTextField
            .rx
            .controlEvent(.editingDidEndOnExit)
            .bind(onNext: {[unowned self] in
                self.view.endEditing(true)
            })
            .disposed(by: rx.disposeBag)
        
        
        [myView.latitudeTextField, myView.longitueTextField].forEach {
            $0.delegate = self
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.myView.middleView.easy.layout(Top(self.myView.bounds.height/2 - 150 - 50))
        self.myView.scrollView.layoutIfNeeded()
        super.viewDidAppear(animated)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard string != "\n" else { return true }
        
        let inverseSet = CharacterSet(charactersIn:"0123456789.").inverted
        let components = string.components(separatedBy: inverseSet)
        let filtered = components.joined(separator: "")
        
        if (textField.text?.contains("."))!, string.contains(".") {
            return false
        }
        
        if string.contains("."), textField.text?.count == 0 {
            textField.text = "0"
        }
        
        return string == filtered
    }

}
