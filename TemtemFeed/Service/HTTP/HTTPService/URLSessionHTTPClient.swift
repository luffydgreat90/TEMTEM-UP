//
//  APIServiceImplementation.swift
//  temtem
//
//  Created by Marlon Ansale on 11/29/22.
//

import Foundation
import Combine

public final class URLSessionHTTPClient: HTTPClient {

    private lazy var queueBackgroundInitiated: DispatchQueue = {
        DispatchQueue(label: "com.temtem.initialize.background",qos: .userInitiated)
    }()

    private let urlSession: URLSession
    
    public init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    public func dispatch(withURL url:URL) -> APIResultPublisher {
        let request = URLRequest(
            url:url
        )
        
        return loadURL(withURLRequest: request)
            .subscribe(on: queueBackgroundInitiated)
            .eraseToAnyPublisher()
    }
    
    private func loadURL(withURLRequest request:URLRequest) -> APIResultPublisher {
        return self.urlSession.dataTaskPublisher(for: request)
			.retry(2)
            .tryMap { result in
                guard let response = result.response as? HTTPURLResponse else{
                    throw URLError(.badServerResponse)
                }
                return (result.data, response)
            }.eraseToAnyPublisher()
    }
    
}
