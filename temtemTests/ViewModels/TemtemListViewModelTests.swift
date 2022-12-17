//
//  TemtemListViewModelTests.swift
//  temtemTests
//
//  Created by Marlon Ansale on 12/17/22.
//

import XCTest
import temtem

final class TemtemListViewModelTests: XCTestCase {

    func makeSUT(file: StaticString = #filePath, line: UInt = #line) -> TemtemListViewModel {
        let sut = TemtemListViewModel(temtemService:MockTemtemService())
        testMemoryLeaks(sut: sut)
        return sut
    }

    func testLaunchPerformance() throws {
      
    }
}
