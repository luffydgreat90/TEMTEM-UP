//
//  ImageNSCacheServiceTest.swift
//  TemtemFeedTests
//
//  Created by Marlon Ansale on 12/10/22.
//

import XCTest
import Foundation
import TemtemFeed

final class ImageNSCacheServiceTest: XCTestCase {
    private let cache:NSCache<NSURL,NSData> = NSCache()
 
    override func setUp() {
        cache.removeAllObjects()
    }

    override func tearDown() {
        cache.removeAllObjects()
    }
    
    func makeSUT(file: StaticString = #filePath, line: UInt = #line) -> ImageNSCacheService {
        let sut = ImageNSCacheService()
        testMemoryLeaks(sut: sut, file: file, line: line)
        return sut
    }

    
    func test_retrieve_none() throws {
        let sut = makeSUT()
        XCTAssertThrowsError(try sut.retrieve(dataForURL: makeURL()))
    }
    
    func test_save_then_retrieve() throws {
        let sut = makeSUT()
        let url = makeURL()
        let data = makeData("123")
        
        try sut.insert(data, for: url)
        XCTAssertEqual(data, try sut.retrieve(dataForURL: url))
    }
    
    func test_save_same_url_then_retrieve() throws {
        let sut = makeSUT()
        let url = makeURL()
        let data = makeData("1234")
        
        try sut.insert(makeData("123"), for: url)
        try sut.insert(data, for: url)
        
        XCTAssertEqual(data , try sut.retrieve(dataForURL: url))
    }

}
