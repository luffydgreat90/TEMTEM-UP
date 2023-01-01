//
//  APIServiceImplementation.swift
//  temtem
//
//  Created by Marlon Ansale on 11/29/22.
//

import Foundation
import Combine

public final class URLSessionHTTPClient: HTTPClient {


    private let urlSession: URLSession
    
    public init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    public func dispatch(withURL url:URL) -> APIResultPublisher {
        let request = URLRequest(
            url:url
        )
        
        return loadURL(withURLRequest: request)
			.retry(2)
            .eraseToAnyPublisher()
    }
    
    private func loadURL(withURLRequest request:URLRequest) -> APIResultPublisher {
        return self.urlSession.dataTaskPublisher(for: request)
            .tryMap { result in
				guard result.data.count > 0, let response = result.response as? HTTPURLResponse else{
                    throw URLError(.badServerResponse)
                }
                return (result.data, response)
            }.eraseToAnyPublisher()
    }
    
}
