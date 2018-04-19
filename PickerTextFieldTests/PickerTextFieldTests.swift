//
//  PickerTextFieldTests.swift
//  PickerTextFieldTests
//
//  Created by Robert Carrier on 4/12/18.
//  Copyright © 2018 rwc. All rights reserved.
//

import XCTest
@testable import PickerTextField

class PickerTextFieldTests: XCTestCase {
    var pickerField: PickerTextField!
    let testData = ["Test1", "Test2", "Test3"]
    
    override func setUp() {
        super.setUp()
        
        pickerField = PickerTextField(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testSetData() {
        pickerField.data = testData
        
        XCTAssertNotNil(pickerField.data)
        XCTAssertFalse(pickerField.data.isEmpty)
    }
    
    func testSetSelection() {
        pickerField.data = testData
        
        XCTAssertNoThrow(try pickerField.setSelection(value: "Test1"))
    }
    
    func testSetBadSelection() {
        XCTAssertThrowsError(try pickerField.setSelection(value: "BadTest"))
    }
    
    func testGetSelectedValue() {
        pickerField.data = testData
        
        try! pickerField.setSelection(value: "Test1")
        
        XCTAssertNotNil(pickerField.selectedValue)
        XCTAssertEqual(pickerField.selectedValue, "Test1")
    }
    
    func testGetSelectedValueNone() {
        let value = pickerField.selectedValue
        
        XCTAssertNil(value)
    }
    
    func testClearSelection() {
        pickerField.data = testData
        
        try! pickerField.setSelection(value: "Test1")
        
        XCTAssertTrue(pickerField.clearSelection())
        XCTAssertNil(pickerField.selectedValue)
    }
    
    func testInputViewWhenEditing() {
        _ = pickerField.textFieldShouldBeginEditing(pickerField)
        
        XCTAssertTrue(pickerField.inputView is UIPickerView)
        XCTAssertTrue(pickerField.inputAccessoryView is UIToolbar)
    }
}
