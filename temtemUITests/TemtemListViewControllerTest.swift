//
//  temtemUITests.swift
//  temtemUITests
//
//  Created by Marlon Ansale on 12/16/22.
//

import XCTest

final class temtemUITests: XCTestCase {
    func test_onLaunch_display_temtem(){
        let app = XCUIApplication()
        app.launch()
        
        let temtemCells = app.cells.matching(identifier: "TemtemCell")
        
        XCTAssertTrue(temtemCells.element.exists)
    }
    
}
