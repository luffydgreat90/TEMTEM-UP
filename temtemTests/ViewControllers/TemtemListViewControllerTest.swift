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
        let sut: TemtemListViewController = TemtemListFactory.createTemtemListViewController(
            temtemService: temtemService,
            imageLoader: loadImageDataPublisher(from:),
            selection: { _ in })

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
    
}
