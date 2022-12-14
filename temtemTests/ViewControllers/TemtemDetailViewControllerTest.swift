//
//  TemtemDetailViewControllerTest.swift
//  temtemTests
//
//  Created by Marlon Ansale on 11/25/22.
//

import XCTest
import temtem

final class TemtemDetailViewControllerTest: XCTestCase {
    
    private func makeSUT(file: StaticString = #filePath, line: UInt = #line) -> TemtemDetailViewController {
        let sut: TemtemDetailViewController =
        TemtemDetailFactory.createTemtemDetailViewController(
            temtemViewModel: mockTemtemViewModel1,
            imageLoader: loadImageDataPublisher(from:))

        sut.loadViewIfNeeded()
        testMemoryLeaks(sut: sut, file: file, line: line)
        
        return sut
    }
    
    func test_setup_ui() throws {
        let sut = makeSUT()
        XCTAssertEqual(sut.title, mockTemtemViewModel1.numberLabel)
        XCTAssertEqual(sut.customView.nameLabel.text, mockTemtemViewModel1.temtemName)
        XCTAssertEqual(sut.customView.typesStackView.subviews.count, mockTemtemViewModel1.types.count)
    }
    
}
