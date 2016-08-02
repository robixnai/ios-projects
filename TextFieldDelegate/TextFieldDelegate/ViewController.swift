//
//  ViewController.swift
//  TextFieldDelegate
//
//  Created by Guilherme Silva on 02/08/16.
//  Copyright © 2016 Guilherme B G Silva. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var zipCodeTextField: UITextField!
    @IBOutlet weak var cashTextField: UITextField!
    @IBOutlet weak var lockableTextField: UITextField!
    @IBOutlet weak var lockableSwitch: UISwitch!
    
    let zipCodeTextFieldDelegate = ZipCodeTextFieldDelegate()
    let cashTextFieldDelegate = CashTextFieldDelegate()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        zipCodeTextField.delegate = zipCodeTextFieldDelegate
        cashTextField.delegate = cashTextFieldDelegate
        lockableTextField.delegate = self
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        return lockableSwitch.on
    }
}

