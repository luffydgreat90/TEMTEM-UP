//
//  APIServiceTest.swift
//  temtemTests
//
//  Created by Marlon Ansale on 11/28/22.
//

import XCTest
import temtem
import Combine

final class URLSessionHTTPClientTest: XCTestCase {
    
    private var cancelable = Set<AnyCancellable>()

    override class func tearDown() {
        URLProtocolStub.removeStub()
    }

    func test_dispatch_files_on_error_request(){
        let error = makeError()
        let receivedError = resultError(forData: nil, response: nil, error: error)
        XCTAssertNotNil(receivedError)
    }
    
    private func makeError(_ desc:String = "Test Error") -> NSError {
        let userInfo = [NSLocalizedDescriptionKey: desc]
        return NSError(domain: "com.test.error", code: 0, userInfo: userInfo)
    }
}

private extension URLSessionHTTPClientTest {
    
    func makeSUT(file: StaticString = #filePath, line: UInt = #line) -> HTTPClient {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLProtocolStub.self]
        let session = URLSession(configuration: configuration)
        
        let sut = URLSessionHTTPClient(urlSession: session)
        testMemoryLeaks(sut: sut, file: file, line: line)
        return sut
    }
    
    func resultError(forData data:Data?, response:URLResponse?, error:Error?, file: StaticString = #filePath, line: UInt = #line) -> Error? {
        URLProtocolStub.stub(data: data, response: response, error: error)
        var receivedError:Error?
        let exp = expectation(description: "Await Completion.")
        let sut = makeSUT(file:file, line: line)
    
        sut.dispatch(withAppendURL: "test").sink { result in
            switch result {
            case let .failure(error): receivedError = error
                break
            default:
                XCTFail("Expected failure but got \(result) instead", file: file, line: line)
                break
            }
            
            exp.fulfill()
        } receiveValue: { _ in
            
        }.store(in: &cancelable)
        wait(for: [exp], timeout: 0.1)
        
        return receivedError
    }
    
    func resultSuccess(forData data:Data?, response:URLResponse?, error:Error?, file: StaticString = #filePath, line: UInt = #line) -> (Data, HTTPURLResponse)? {
        URLProtocolStub.stub(data: data, response: response, error: error)
        var receivedValues: (Data, HTTPURLResponse)?
        let exp = expectation(description: "Await Completion.")
        let sut = makeSUT(file:file, line: line)
    
        sut.dispatch(withAppendURL: "test").sink { result in
            switch result {
            case .finished:
                break
            default:
                XCTFail("Expected success but got \(result) instead", file: file, line: line)
                break
            }
        } receiveValue: { values in
            receivedValues = values
            exp.fulfill()
        }.store(in: &cancelable)
        
        wait(for: [exp], timeout: 0.1)
        
        return receivedValues
    }
}
