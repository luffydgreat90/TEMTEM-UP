//
//  XCTestCase+MemoryLeaks.swift
//  temtemTests
//
//  Created by Marlon Ansale on 11/29/22.
//

import XCTest

extension XCTestCase {
    func testMemoryLeaks(sut:AnyObject, file: StaticString = #filePath, line: UInt = #line) {
        addTeardownBlock { [weak sut] in
            XCTAssertNil(sut, file: file, line: line)
        }
    }
}
