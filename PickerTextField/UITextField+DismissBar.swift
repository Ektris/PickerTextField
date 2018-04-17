//
//  UITextField+DismissBar.swift
//  PickerTextField
//
//  Created by Robert Carrier on 4/17/18.
//  Copyright © 2018 rwc. All rights reserved.
//

import UIKit

internal extension UITextField {
    internal func addDismissBar() {
        let dismissBar = UIToolbar(frame: .zero)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissEditor))
        dismissBar.setItems([doneButton], animated: false)
        dismissBar.sizeToFit()
        dismissBar.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        dismissBar.translatesAutoresizingMaskIntoConstraints = false
        
        self.inputAccessoryView = dismissBar
    }
    
    @objc fileprivate func dismissEditor() {
        self.resignFirstResponder()
    }
}
