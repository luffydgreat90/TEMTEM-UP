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
    
    func test_searched_data_fetched() throws {
        let sut = makeSUT()
        let expectation = XCTestExpectation(description: "Search Temtem from Cache.")
        
        expect(sut: sut, expectedNumber: 1, description: "Should return 1 temtem.", expectation: expectation)
        
        sut.fetchTemtems()
        sut.searchTemtem(search: "Golz")
        wait(for: [expectation], timeout:  1)
    }
    
    func test_searched_none() throws {
        let sut = makeSUT()
        let expectation = XCTestExpectation(description: "No Temtem found.")
        
        expect(sut: sut, expectedNumber: 0, description: "No Temtem found.", expectation: expectation)
        
        sut.fetchTemtems()
        sut.searchTemtem(search: "none")
        
        wait(for: [expectation], timeout:  1)
        
    }
    
    private func expect(sut:TemtemListViewModel,
                             expectedNumber:Int,
                             description:String,
                             expectation:XCTestExpectation,
                             file: StaticString = #filePath,
                             line: UInt = #line){
        
        sut.$temtems.dropFirst(2)
            .sink { temtems in
                XCTAssertEqual(temtems.count,
                               expectedNumber,
                               description,
                               file: file,
                               line: line)
                expectation.fulfill()
        }.store(in: &cancellables)
        
    }
}
