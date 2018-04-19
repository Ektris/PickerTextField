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
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
