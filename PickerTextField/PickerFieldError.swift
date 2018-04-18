//
//  File.swift
//  PickerTextField
//
//  Created by Robert Carrier on 4/18/18.
//  Copyright © 2018 rwc. All rights reserved.
//

import Foundation

enum PickerFieldError: Error {
    case invalidSelection
}

extension PickerFieldError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .invalidSelection:
            return "Invalid selection made."
        }
    }
}
