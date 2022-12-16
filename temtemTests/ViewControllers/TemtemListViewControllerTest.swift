//
//  TemtemListViewControllerTest.swift
//  temtemTests
//
//  Created by Marlon Ansale on 11/13/22.
//

import XCTest
import Combine
import temtem
import TemtemFeed

final class TemtemListViewControllerTest: XCTestCase {

    private var cancellables = Set<AnyCancellable>()
    
    private func makeSUT(withMockService temtemService:TemtemService = MockTemtemService(), file: StaticString = #file, line: UInt = #line) -> TemtemListViewController {
        let sut: TemtemListViewController = TemtemListFactory.createTemtemListViewController(temtemService: temtemService)
        sut.loadViewIfNeeded()
        testMemoryLeaks(sut: sut)
        return sut
    }
    
    func test_setup_ui() throws {
        let sut = makeSUT()
        XCTAssertEqual(sut.title, "Hello Tamers!")
        XCTAssertNotNil(sut.customView.tableView.dataSource)
        XCTAssertNotNil(sut.customView.tableView.delegate)
    }
    
    func test_data_fetched() throws {
        let sut = makeSUT()
        let expectation = XCTestExpectation(description: "Data Fetched From API.")
        
        sut.viewModel.$temtems.sink { temtems in
            XCTAssertEqual(temtems.count, 2)
            expectation.fulfill()
        }.store(in: &cancellables)
        
        wait(for: [expectation], timeout:  0.1)
    }
    
    func test_search_temtem() throws {
        let sut = makeSUT()
        let expectation = XCTestExpectation(description: "Should have 1 searched.")
        
        sut.viewModel.$temtems.dropFirst().sink { temtems in
            XCTAssertEqual(temtems.count, 1)
            
            expectation.fulfill()
        }.store(in: &cancellables)
        
        sut.viewModel.searchTemtem(search: "golz")
        
        wait(for: [expectation], timeout:  0.1)
        
    }
    
    func test_empty_search_temtem() throws {
        let sut = makeSUT()
        let expectation = XCTestExpectation(description: "Should have Empty List.")
        
        sut.viewModel.$temtems.dropFirst().sink { [weak sut] temtems in
            XCTAssertEqual(temtems.count, 0)
            XCTAssertFalse(sut!.customView.errorLabel.isHidden)
            
            expectation.fulfill()
        }.store(in: &cancellables)
        
        sut.viewModel.searchTemtem(search: "smazee")
        
        wait(for: [expectation], timeout:  0.1)
    }
    
    
    func test_empty_service() throws {
        let sut = makeSUT(withMockService: MockTemtemServiceEmpty())
        let expectation = XCTestExpectation(description: "Should return success but empty data.")
        
        sut.viewModel.$temtems.sink { temtems in
            XCTAssertEqual(temtems.count, 0)
            expectation.fulfill()
        }.store(in: &cancellables)
        
        wait(for: [expectation], timeout:  0.1)
        
    }
    
}
