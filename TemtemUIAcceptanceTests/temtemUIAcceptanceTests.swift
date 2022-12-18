//
//  temtemUIAcceptanceTests.swift
//  temtemUIAcceptanceTests
//
//  Created by Marlon Ansale on 12/16/22.
//

import XCTest


final class temtemUIAcceptanceTests: XCTestCase {
    func test_onLaunch_display_temtem(){
        let app = XCUIApplication()
        app.launch()
        
        let temtemCells = app.cells.matching(identifier: "TemtemCell")
        XCTAssertEqual( temtemCells.count, 2)
    }
}
