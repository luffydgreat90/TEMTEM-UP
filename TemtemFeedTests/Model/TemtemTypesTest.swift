//
//  TemtemTypesTest.swift
//  temtemTests
//
//  Created by Marlon Ansale on 11/28/22.
//

import XCTest
import TemtemFeed

final class TemtemTypesTest: XCTestCase {
    
    func test_types_found() throws {
        let typesString = ["Crystal", "Earth", "Neutral", "Fire", "Nature", "Electric"
                           ,"Mental" , "Wind" , "Digital" ,"Melee" , "Toxic" ,"Water"]
        
        typesString.forEach { type in
            XCTAssertNotEqual(TemtemTypes.unowned, TemtemTypes(withType: type), "Should be a Valid type.")
        }
    }
    
    func test_type_not_found() throws {
        XCTAssertEqual(TemtemTypes.unowned, TemtemTypes(withType: "Waters"), "Should not be a Valid type.")
        XCTAssertEqual(TemtemTypes.unowned, TemtemTypes(withType: "$%$$@#$#@$"), "Should not be a Valid type.")
    }
}
