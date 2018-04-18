//
//  MultiPickerTextField.swift
//  PickerTextField
//
//  Created by Robert Carrier on 4/13/18.
//  Copyright © 2018 rwc. All rights reserved.
//

import UIKit

open class MultiPickerTextField: PickerTextField, UITableViewDataSource, UITableViewDelegate {
    // MARK: - Properties
    
    fileprivate let table = UITableView()
    fileprivate var identifier = "cell"
    
    override open var data: [String] {
        set (values) {
            self._data = values
        }
        get {
            return self._data
        }
    }
    
    fileprivate var selectedRows = [Int]()
    
    open var selectedValues: [String]? {
        get {
            if selectedRows.count > 0 {
                var values = [String]()
                for row in selectedRows {
                    values.append(data[row])
                }
                return values
            } else {
                return nil
            }
        }
    }
    
    override open internal(set) var selectedValue: String? {
        set {
            super.selectedValue = nil
        }
        get {
            if let values = self.selectedValues {
                return values.joined(separator: ",")
            } else {
                return nil
            }
        }
    }
    
    // MARK: - Initializers
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        initTableView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initTableView()
    }
    
    fileprivate func initTableView() {
        self.delegate = self
        
        self.table.dataSource = self
        self.table.delegate = self
        self.table.allowsMultipleSelection = true
        self.table.backgroundColor = .clear
        self.table.separatorStyle = .none
        
        self.table.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: identifier)
    }
    
    // MARK: - Selection Handlers
    
    override internal func setSelection(_ row: Int) {
        if !self.selectedRows.contains(row) {
            self.selectedRows.append(row)
        }
        setText()
    }
    
    override open func setSelection(value: String) throws {
        if self._data.contains(value) {
            let indexPath = IndexPath(row: self._data.index(of: value)!, section: 0)
            self.table.selectRow(at: indexPath, animated: false, scrollPosition: .none)
            tableView(self.table, didSelectRowAt: indexPath)
        } else {
            throw PickerFieldError.invalidSelection
        }
    }
    
    open func setSelections(values: [String]) throws {
        _ = clearSelection()
        
        for value in values {
            if self._data.contains(value) {
                try! setSelection(value: value)
            } else {
                throw PickerFieldError.invalidSelection
            }
        }
    }
    
    override open func clearSelection() -> Bool {
        for row in self.selectedRows {
            let path = IndexPath(row: row, section: 0)
            self.table.deselectRow(at: path, animated: true)
            tableView(self.table, didDeselectRowAt: path)
        }
        
        return true
    }
    
    override internal func setText() {
        self.text = selectedValue
    }
    
    // MARK: - UITextFieldDelegate
    
    open override func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.table.frame = self.picker.frame
        self.table.reloadData()
        self.inputView = self.table
        self.inputView?.backgroundColor = .clear

        addDismissBar()
        
        return true
    }
    
    // MARK: - UITableViewDataSource
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self._data.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        
        cell.selectionStyle = .none

        cell.backgroundColor = UIColor.clear
        
        let row = indexPath.row

        cell.textLabel?.text = self._data[row]

        if self.selectedRows.contains(row) {
            cell.accessoryType = .checkmark
            cell.setSelected(true, animated: false)
        } else {
            cell.accessoryType = .none
            cell.setSelected(false, animated: false)
        }

        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        if self.selectedRows.contains(indexPath.row) {
            tableView.deselectRow(at: indexPath, animated: true)
            self.tableView(tableView, didDeselectRowAt: indexPath)
            return
        }
        
        cell?.accessoryType = .checkmark
        
        setSelection(indexPath.row)
    }
    
    public func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .none
        
        self.selectedRows.remove(at: self.selectedRows.index(of: indexPath.row)!)
        setText()
    }
}
