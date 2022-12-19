//
//  TemtemMapperTest.swift
//  temtemTests
//
//  Created by Marlon Ansale on 11/29/22.
//

import TemtemFeed
import XCTest

final class TemtemMapperTest: XCTestCase {
    
    func test_map_throws_error() throws {
        let data = makeData("not-empty-data")
        let errorResponses:[Int] = [201, 300, 404, 500]
        
        try errorResponses.forEach { response in
        
            XCTAssertThrowsError(
                try TemtemMapper.map(data, response: makeHTTPResponse(withResponseCode: response))
            )
        }
    }
    
    func test_map_data_empty_error() throws {
        let emptyData = makeData()
        
        XCTAssertThrowsError(
            try TemtemMapper.map(emptyData, response: makeHTTPResponse(withResponseCode: 200))
        )
    }
    
    func test_map_success() throws {
        let data:Data = try getTemtemData()
        let response:Int = HTTPURLResponse.IS_OK
        
        XCTAssertNoThrow(
            try TemtemMapper.map(data, response: makeHTTPResponse(withResponseCode: response))
        )
    }
    
    func test_map_check_map() throws {
        let data:Data = try getTemtemData()
        let response:Int = HTTPURLResponse.IS_OK
        
        let temtems:[TemtemViewModel] =  try TemtemMapper.map(data, response: makeHTTPResponse(withResponseCode: response))
        
        XCTAssertFalse(temtems.isEmpty)
        
        let temtem:TemtemViewModel? = temtems.first
        
        XCTAssertEqual("Mimit", temtem?.temtemName)
        XCTAssertEqual("#1", temtem?.numberLabel)
        XCTAssertEqual(1, temtem?.types.count)
        XCTAssertEqual(TemtemTypes.digital, temtem?.types.first)
        XCTAssertEqual(["Striking Transmog","Landing Transmog"], temtem?.traits)
        XCTAssertEqual("Mimit has the honor of being the very first Digital ever created. The genomic reservoir contained in its tail allows it an unequalled ability to replicate any other Temtem species, making it the ultimate breeder.", temtem?.gameDescription)
    }
    
    private func makeHTTPResponse(withResponseCode code:Int) -> HTTPURLResponse {
        HTTPURLResponse(url: makeURL(), statusCode: code,httpVersion: "1", headerFields: [:])!
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
