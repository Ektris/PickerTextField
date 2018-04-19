//
//  MultiPickerTextFieldTests.swift
//  PickerTextFieldTests
//
//  Created by Robert Carrier on 4/18/18.
//  Copyright © 2018 rwc. All rights reserved.
//

import XCTest
@testable import PickerTextField

class MultiPickerTextFieldTests: XCTestCase {
    var multiPickerField: MultiPickerTextField!
    let testData = ["Test1", "Test2", "Test3", "Test4", "Test5", "Test6", "Test7", "Test8"]
    
    override func setUp() {
        super.setUp()
        
        multiPickerField = MultiPickerTextField(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSetData() {
        multiPickerField.data = testData
        
        XCTAssertNotNil(multiPickerField.data)
    }
    
    func testSetSingleSelection() {
        multiPickerField.data = testData
        
        XCTAssertNoThrow(try multiPickerField.setSelection(value: "Test1"))
    }
    
    func testSetMultiSelection() {
        multiPickerField.data = testData
        
        XCTAssertNoThrow(try multiPickerField.setSelections(values: ["Test1", "Test2", "Test3"]))
    }
    
    func testSetBadSelection() {
        multiPickerField.data = testData
        
        XCTAssertThrowsError(try multiPickerField.setSelection(value: "Bad Test"))
    }

    func testSetBadMultiSelection() {
        multiPickerField.data = testData
        
        XCTAssertThrowsError(try multiPickerField.setSelections(values: ["Test1", "Bad Test"]))
    }
    
    func testGetSelectedValueSingle() {
        multiPickerField.data = testData
        
        try! multiPickerField.setSelection(value: "Test1")
        
        XCTAssertNotNil(multiPickerField.selectedValue)
        XCTAssertEqual(multiPickerField.selectedValue, "Test1")
    }
    
    func testGetSelectedValueMulti() {
        multiPickerField.data = testData
        
        try! multiPickerField.setSelections(values: ["Test1", "Test4"])
        
        XCTAssertNotNil(multiPickerField.selectedValue)
        XCTAssertEqual(multiPickerField.selectedValue, "Test1,Test4")
    }
    
    func testGetSelectedValues() {
        multiPickerField.data = testData
        
        try! multiPickerField.setSelections(values: ["Test1", "Test4"])
        
        XCTAssertNotNil(multiPickerField.selectedValues)
        XCTAssertEqual(multiPickerField.selectedValues, ["Test1", "Test4"])
    }
    
    func testGetSelectedValueNone() {
        let value = multiPickerField.selectedValue
        
        XCTAssertNil(value)
    }
    
    func testGetSelectedValuesNone() {
        let values = multiPickerField.selectedValues
        
        XCTAssertNil(values)
    }
    
    func testClearSelection() {
        multiPickerField.data = testData
        
        try! multiPickerField.setSelections(values: ["Test1", "Test4"])
        
        XCTAssertTrue(multiPickerField.clearSelection())
        XCTAssertNil(multiPickerField.selectedValue)
        XCTAssertNil(multiPickerField.selectedValues)
    }
    
    func testInputViewWhenEditing() {
        _ = multiPickerField.textFieldShouldBeginEditing(multiPickerField)
        
        XCTAssertTrue(multiPickerField.inputView is UITableView)
        XCTAssertTrue(multiPickerField.inputAccessoryView is UIToolbar)
    }
}
