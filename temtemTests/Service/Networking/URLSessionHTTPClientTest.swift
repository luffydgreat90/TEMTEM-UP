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
    
    func test_dispatch_failed_on_invalid_representation_cases() throws {
        /*
         These cases should *never* happen, however as `URLSession` represents these fields as optional
         it is possible in some obscure way that this state _could_ exist.
         | Data?    | URLResponse?      | Error?   |
         |----------|-------------------|----------|
         | nil      | nil               | nil      |
         | nil      | URLResponse       | nil      |
         | value    | nil               | nil      |
         | value    | nil               | value    |
         | nil      | URLResponse       | value    |
         | nil      | HTTPURLResponse   | value    |
         | value    | HTTPURLResponse   | value    |
         | value    | URLResponse       | nil      |
         */
        
        let nonHTTPURLResponse = URLResponse(url: makeURL(), mimeType: nil, expectedContentLength: 0, textEncodingName: nil)
        let httpResponse = HTTPURLResponse(url: makeURL(), statusCode: 200, httpVersion: nil, headerFields: nil)
        let error = makeError()
        let data = makeData()
        
        XCTAssertNotNil(resultError(forData: nil, response: nil, error: nil))
        XCTAssertNotNil(resultError(forData: nil, response: httpResponse, error: nil))
        XCTAssertNotNil(resultError(forData: data, response: nil, error: nil))
        XCTAssertNotNil(resultError(forData: data, response: nil, error: error))
        XCTAssertNotNil(resultError(forData: nil, response: nonHTTPURLResponse, error: nil))
        XCTAssertNotNil(resultError(forData: data, response: httpResponse, error: error))
        XCTAssertNotNil(resultError(forData: nil, response: httpResponse, error: error))
        XCTAssertNotNil(resultError(forData: data, response: httpResponse, error: nil))
    }
    
    func test_dispatch_succeeds_on_http_url_response_with_data() throws {
        let httpResponse = HTTPURLResponse(url: makeURL(), statusCode: 200, httpVersion: nil, headerFields: nil)
        let data = makeData("has data")
        let resultSuccess = resultSuccess(forData: data, response: httpResponse, error: nil)
        
        XCTAssertEqual(resultSuccess?.data, data, "Has data")
        XCTAssertEqual(resultSuccess?.response.statusCode, 200, "Return success response.")
        
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
        let exp = expectation(description: "Await Error Completion.")
        let sut = makeSUT(file:file, line: line)
    
        sut.dispatch(withURL: makeURL()).sink { result in
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
    
    func resultSuccess(forData data:Data?, response:URLResponse?, error:Error?, file: StaticString = #filePath, line: UInt = #line) -> (data: Data, response: HTTPURLResponse)? {
        URLProtocolStub.stub(data: data, response: response, error: error)
        var receivedValues: (data: Data,response: HTTPURLResponse)?
        let exp = expectation(description: "Await Success Completion.")
        let sut = makeSUT(file:file, line: line)
    
        sut.dispatch(withURL: makeURL()).sink { result in
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
