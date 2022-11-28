//
//  TemtemTypesTest.swift
//  temtemTests
//
//  Created by Marlon Ansale on 11/28/22.
//

import XCTest
@testable import temtem

final class TemtemTypesTest: XCTestCase {
    
    func test_type_found() throws {
        let typesString = ["Crystal", "Earth", "Neutral", "Fire", "Nature", "Electric"
                           ,"Mental" , "Wind" , "Digital" ,"Melee" , "Toxic" ,"Water"]
        typesString.forEach { type in
            XCTAssertNotEqual(TemtemTypes.unowned, TemtemTypes(withType: type), "Should be a valid type")
        }
    }
    
    func test_type_not_found() throws {
        XCTAssertEqual(TemtemTypes.unowned, TemtemTypes(withType: "Waters"))
        XCTAssertEqual(TemtemTypes.unowned, TemtemTypes(withType: "$%$$@#$#@$"))
    }
}
