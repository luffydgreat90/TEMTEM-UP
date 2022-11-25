//
//  TemtemCellTest.swift
//  temtemTests
//
//  Created by Marlon Ansale on 11/15/22.
//

import XCTest

@testable import temtem
final class TemtemCellTest: XCTestCase {

    func makeData() -> TemtemViewModel {
        let temtem1 = Temtem(number: 1, name: "Anahir", portraitWikiUrl: URL(string: "test")!, gameDescription: "test", traits: [], types: [ "Crystal"], techniques: [], icon: "star", lumaIcon: "star")
        return TemtemViewModel(temtem: temtem1)
    }
    
    func test_cell_bind() throws {
        let temtemViewModel = makeData()
        
        let cell = TemtemCell()
        cell.bind(viewModel: temtemViewModel)
        
        XCTAssertEqual(cell.titleLabel.text, "Anahir")
        XCTAssertEqual(cell.numberLabel.text, "#1")
        XCTAssertEqual(cell.typeElementStackView.arrangedSubviews.count, 1)
    }

}
