//
//  PickerTextField.swift
//  PickerTextField
//
//  Created by Robert Carrier on 4/12/18.
//  Copyright © 2018 rwc. All rights reserved.
//

import UIKit

open class PickerTextField: UITextField, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    // MARK: - Properties
    
    internal let picker = UIPickerView()
    
    internal var _data = [String]()
    
    open var data: [String] {
        set (values) {
            var newValues = [""]
            newValues.append(contentsOf: values)
            self._data = newValues
        }
        get {
            return self._data
        }
    }
    
    open internal(set) var selectedValue: String?
    
    // MARK: - Initializers
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        initPickerView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initPickerView()
    }
    
    private func initPickerView() {
        self.delegate = self
        
        self.picker.dataSource = self
        self.picker.delegate = self
        self.picker.autoresizingMask = [.flexibleHeight]
        self.picker.translatesAutoresizingMaskIntoConstraints = false
        self.picker.showsSelectionIndicator = true
        self.picker.isUserInteractionEnabled = true
    }
    
    // MARK: - Selection handlers
    
    internal func setSelection(_ row: Int) {
        self.selectedValue = self._data[row]
        setText()
    }
    
    public func clearSelection() -> Bool {
        self.picker.selectRow(0, inComponent: 0, animated: false)
        pickerView(self.picker, didSelectRow: 0, inComponent: 0)
        return true
    }
    
    internal func setText() {
        self.text = self.selectedValue
    }
    
    // MARK: - UITextFieldDelegate
    
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.inputView = self.picker
        
        self.inputAccessoryView = createDismissBar()
        
        return true
    }
    
    internal func createDismissBar() -> UIToolbar {
        let dismissBar = UIToolbar(frame: .zero)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissEditor))
        dismissBar.setItems([doneButton], animated: false)
        dismissBar.sizeToFit()
        dismissBar.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        dismissBar.translatesAutoresizingMaskIntoConstraints = false
        
        return dismissBar
    }
    
    open func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    
    open func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return clearSelection()
    }
    
    @objc fileprivate func dismissEditor() {
        self.resignFirstResponder()
    }
    
    // MARK: - UIPickerViewDataSource
    
    open func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    open func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self._data.count
    }
    
    // MARK: - UIPickerViewDelegate
    
    open func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self._data[row]
    }
    
    open func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        setSelection(row)
    }
}
