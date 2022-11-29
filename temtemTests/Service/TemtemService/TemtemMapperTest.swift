//
//  TemtemMapperTest.swift
//  temtemTests
//
//  Created by Marlon Ansale on 11/29/22.
//

import temtem
import XCTest

final class TemtemMapperTest: XCTestCase {
    
    func test_map_throws_error() throws {
        let data = makeData()
        let errorResponses:[Int] = [201, 300, 404, 500]
        
        try errorResponses.forEach { response in
            XCTAssertThrowsError(
                try TemtemMapper.map(data, response: response)
            )
        }
    }
    
    func test_map_success() throws {
        let data:Data = try getTemtemData()
        let response:Int = HTTPURLResponse.IS_OK
        
        XCTAssertNoThrow(try TemtemMapper.map(data, response: response))
    }
    
    func test_map_check_map() throws {
        let data:Data = try getTemtemData()
        let response:Int = HTTPURLResponse.IS_OK
        
        let temtems:[TemtemViewModel] =  try TemtemMapper.map(data, response: response)
        
        XCTAssertFalse(temtems.isEmpty)
        
        let temtem:TemtemViewModel? = temtems.first
        
        XCTAssertEqual("Mimit", temtem?.temtemName)
    }
}

extension TemtemMapperTest {
    
    func getTemtemData() throws -> Data {
        let filename: String = "temtem.json"
        
        guard let file = Bundle.main.url(forResource: filename, withExtension: nil) else {
            throw TemtemMapper.Error.invalidData
        }
        
        guard let data = try? Data(contentsOf: file) else {
            throw TemtemMapper.Error.invalidData
        }

        return data
        
    }
    
}
