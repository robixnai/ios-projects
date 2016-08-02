//
//  ZipCodeTextFieldDelegate.swift
//  TextFieldDelegate
//
//  Created by Guilherme Silva on 02/08/16.
//  Copyright © 2016 Guilherme B G Silva. All rights reserved.
//

import Foundation
import UIKit

class ZipCodeTextFieldDelegate: NSObject, UITextFieldDelegate {
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if let stringText = textField.text {
            if stringText.characters.count >= 5 {
                return false
            }
        }
        
        return true
    }
}
