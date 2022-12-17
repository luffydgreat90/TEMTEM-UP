//
//  TemtemListViewModelTests.swift
//  temtemTests
//
//  Created by Marlon Ansale on 12/17/22.
//

import XCTest
import temtem
import Combine

final class TemtemListViewModelTests: XCTestCase {
    private var cancellables = Set<AnyCancellable>()
    
    func makeSUT(file: StaticString = #filePath, line: UInt = #line) -> TemtemListViewModel {
        let sut = TemtemListViewModel(temtemService:MockTemtemService())
        testMemoryLeaks(sut: sut)
        return sut
    }

    func test_data_fetched() throws {
        let sut = makeSUT()
        let expectation = XCTestExpectation(description: "Data Fetched From API.")
        
        sut.$temtems.dropFirst()
            .sink { temtems in
                XCTAssertEqual(temtems.count, 2)
                expectation.fulfill()
        }.store(in: &cancellables)
        
        sut.fetchTemtems()
        wait(for: [expectation], timeout:  1)
    }
}
