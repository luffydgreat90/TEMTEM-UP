//
//  TemtemListViewControllerTest.swift
//  temtemTests
//
//  Created by Marlon Ansale on 11/13/22.
//

import XCTest
import Combine
@testable import temtem
final class TemtemListViewControllerTest: XCTestCase {

    private var cancellables = Set<AnyCancellable>()
    
    func makeSUT() -> TemtemListViewController {
        let temtemListViewController: TemtemListViewController = TemtemListFactory.createTemtemListViewController(temtemService: MockTemtemService())
        
        temtemListViewController.loadViewIfNeeded()
        return temtemListViewController
    }
    
    func test_setup_binding() throws {
        let sut = makeSUT()
        XCTAssertEqual(sut.title, "Temtem UP!")
        XCTAssertNotNil(sut.customView.tableView.dataSource)
        XCTAssertNotNil(sut.customView.tableView.delegate)
    }
    
    func test_data_fetched() throws {
        let sut = makeSUT()
        let expectation = XCTestExpectation(description: "Data Fetched From API")
        
        sut.viewModel.$temtems.sink { temtems in
            XCTAssertEqual(temtems.count, 2)
            expectation.fulfill()
        }.store(in: &cancellables)
        
        wait(for: [expectation], timeout:  0.1)
    }
    
    func test_search_temtem() throws {
        let sut = makeSUT()
        let expectation = XCTestExpectation(description: "Should have 1 searched ")
        
        sut.viewModel.$temtems.dropFirst().sink { temtems in
            XCTAssertEqual(temtems.count, 1)
            XCTAssertTrue(sut.customView.errorLabel.isHidden)
            
            expectation.fulfill()
        }.store(in: &cancellables)
        
        sut.viewModel.searchTemtem(search: "golz")
        
        wait(for: [expectation], timeout:  0.1)
        
    }
    
    func test_empty_search_temtem() throws {
        let sut = makeSUT()
        let expectation = XCTestExpectation(description: "Should have Empty List ")
        
        sut.viewModel.$temtems.dropFirst().sink { temtems in
            XCTAssertEqual(temtems.count, 0)
            XCTAssertFalse(sut.customView.errorLabel.isHidden)
            
            expectation.fulfill()
        }.store(in: &cancellables)
        
        sut.viewModel.searchTemtem(search: "smazee")
        
        wait(for: [expectation], timeout:  0.1)
    }
    
    
}
