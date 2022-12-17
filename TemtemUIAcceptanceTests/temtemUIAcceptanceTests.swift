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
        XCTAssertEqual( temtemCells.count, 164)
    }
    
    func test_onLaunch_display_offline(){
        let app = XCUIApplication()
        app.launchArguments = ["-connectivity", "offline"]
        app.launch()
        
        let temtemCells = app.cells.matching(identifier: "TemtemCell")
        XCTAssertEqual( temtemCells.count, 0)
    }
}
