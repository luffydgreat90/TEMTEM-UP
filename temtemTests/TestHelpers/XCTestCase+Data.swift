//
//  XCTestCase+Data.swift
//  temtemTests
//
//  Created by Marlon Ansale on 11/29/22.
//

import Foundation
import XCTest

extension XCTestCase {
    func makeData(_ value: String = "") -> Data {
        Data(value.utf8)
    }
}
