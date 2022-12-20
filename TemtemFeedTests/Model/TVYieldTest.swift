//
//  TVYieldTest.swift
//  TemtemFeedTests
//
//  Created by Marlon Ansale on 12/20/22.
//

import XCTest
import TemtemFeed

final class TVYieldTest: XCTestCase {

    func test_yield_types_found() {
        let typesString = ["hp", "sta", "spd", "atk", "def", "spatk"
                           ,"spdef"]
        
        typesString.forEach { yield in
            XCTAssertNotEqual(TVYields.unowned, TVYields(withYield: yield), "Should be a valid Yield Type.")
        }
    }
    
    func test_yield_types_not_found() {
        let typesString = ["hps", "asdad", "speed", "asdsd", "bbb", "spatka"
                           ,"spdefs"]
        
        typesString.forEach { yield in
            XCTAssertEqual(TVYields.unowned, TVYields(withYield: yield), "Should not be valid Yield Type.")
        }
    }
}
