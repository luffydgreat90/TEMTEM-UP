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

    var cancellables = Set<AnyCancellable>()
    
    func makeSUT() -> TemtemListViewController {
        let viewModel = TemtemListViewModel(temtemService: MockTemtemService())
        let temtemListViewController = TemtemListViewController.init(customView: TemtemListView(), viewModel: viewModel)
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
            XCTAssertEqual(temtems.count, 1)
            expectation.fulfill()
        }.store(in: &cancellables)
        
        wait(for: [expectation], timeout:  5.0)
    }
    
    
    
    
}
