//
//  DatePickerTextField.swift
//  PickerTextField
//
//  Created by Robert Carrier on 4/17/18.
//  Copyright © 2018 rwc. All rights reserved.
//

import UIKit

open class DatePickerTextField: UITextField, UITextFieldDelegate {
    // MARK: - Properties
    
    internal let picker = UIDatePicker()
    
    let formatter = DateFormatter()
    
    // MARK: - Initializers
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        initDatePicker()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initDatePicker()
    }
    
    private func initDatePicker() {
        self.delegate = self
        
        self.picker.datePickerMode = .date
        self.picker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        self.picker.autoresizingMask = [.flexibleHeight]
        self.picker.translatesAutoresizingMaskIntoConstraints = false
        
        self.formatter.dateStyle = .medium
    }
    
    // MARK: - Selection Handlers
    
    @objc func dateChanged(_ picker: UIDatePicker) {
        self.text = self.formatter.string(from: picker.date)
    }
    
    // MARK: - UITextFieldDelegate
    
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.inputView = self.picker
        
        addDismissBar()
        
        // Set the text to the current date if empty so that the user can easily accept picker's default instead of scrolling up and down
        if self.text!.isEmpty {
            self.text = self.formatter.string(from: Date())
        }
        
        return true
    }
    
    public func textFieldShouldClear(_ textField: UITextField) -> Bool {
        self.picker.setDate(Date(), animated: true)
        
        return true
    }
}
