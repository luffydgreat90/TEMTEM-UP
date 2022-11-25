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
    
    
}
