//
//  TemtemCellTest.swift
//  temtemTests
//
//  Created by Marlon Ansale on 11/15/22.
//

import XCTest
import temtem

final class TemtemCellTest: XCTestCase {

    func test_cell_bind() throws {
        let temtemViewModel = mockTemtemViewModel1
        
        let cell: TemtemCell = TemtemCell()
        cell.bind(viewModel: temtemViewModel, imageLoader: nil)
        
        XCTAssertEqual(cell.titleLabel.text, "Anahir")
        XCTAssertEqual(cell.numberLabel.text, "#1")
        XCTAssertEqual(cell.typeElementStackView.arrangedSubviews.count, 1)
        XCTAssertEqual(cell.tvYield.text, "HP: 2")
    }

}
