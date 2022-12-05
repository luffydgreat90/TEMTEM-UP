//
//  URLProtocolStub.swift
//  temtemTests
//
//  Created by Marlon Ansale on 12/5/22.
//

import Foundation

class URLProtocolStub: URLProtocol {
    private struct Stub {
        let data: Data?
        let response: URLResponse?
        let error: Error?
        let requestObservers: ((URLRequest) -> Void)?
    }
    
    private static let queue = DispatchQueue(label: "URLProtocolStub.queue")
}
