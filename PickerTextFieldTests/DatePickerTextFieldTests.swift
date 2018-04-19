//
//  DatePickerTextFieldTests.swift
//  PickerTextFieldTests
//
//  Created by Robert Carrier on 4/18/18.
//  Copyright © 2018 rwc. All rights reserved.
//

import XCTest
@testable import PickerTextField

class DatePickerTextFieldTests: XCTestCase {
    var datePickerField: DatePickerTextField!
    
    override func setUp() {
        super.setUp()

        datePickerField = DatePickerTextField(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSetDate() {
        let date = Date()
        datePickerField.setDate(date)
        
        XCTAssertEqual(datePickerField.picker.date, date)
    }
    
    func testGetSelectedDate() {
        let date = Date()
        
        datePickerField.setDate(date)
        
        XCTAssertNotNil(datePickerField.selectedDate)
        XCTAssertEqual(datePickerField.selectedDate, date)
    }
    
    func testGetSelectedDateNone() {
        let date = datePickerField.selectedDate
        
        XCTAssertNil(date)
    }
    
    func testGetDateText() {
        let date = Date()
        
        datePickerField.setDate(date)
        let selected = datePickerField.selectedDate
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        let text = formatter.string(from: selected!)
        
        XCTAssertEqual(datePickerField.text, text)
    }
    
    func testInputViewWhenEditing() {
        _ = datePickerField.textFieldShouldBeginEditing(datePickerField)
        
        XCTAssertTrue(datePickerField.inputView is UIDatePicker)
        XCTAssertTrue(datePickerField.inputAccessoryView is UIToolbar)
    }
}
