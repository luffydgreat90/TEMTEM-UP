//
//  TemtemDetailViewControllerTest.swift
//  temtemTests
//
//  Created by Marlon Ansale on 11/25/22.
//

import XCTest
import Combine

@testable import temtem
final class TemtemDetailViewControllerTest: XCTestCase {
    
    private func makeSUT() -> TemtemDetailViewController {
        let temtemDetailViewController: TemtemDetailViewController =
        TemtemDetailFactory.createTemtemDetailViewController(temtemViewModel: mockTemtemViewModel1)

        temtemDetailViewController.loadViewIfNeeded()
        return temtemDetailViewController
    }
    
    func test_setup_ui() throws {
        let sut = makeSUT()
        XCTAssertEqual(sut.title, mockTemtemViewModel1.numberLabel)
        XCTAssertEqual(sut.customView.nameLabel.text, mockTemtemViewModel1.temtemName)
        XCTAssertEqual(sut.customView.typesStackView.subviews.count, mockTemtemViewModel1.types.count)
    }
    
}
