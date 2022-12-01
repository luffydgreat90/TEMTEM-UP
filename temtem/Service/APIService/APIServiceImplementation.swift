//
//  APIServiceImplementation.swift
//  temtem
//
//  Created by Marlon Ansale on 11/29/22.
//

import Foundation
import Combine

public final class APIServiceImplementation: APIService {

    private lazy var baseURL:URL = {
        URL(string: String.urlBase)!
    }()
    
    public func dispatch(withAppendURL url:String) -> APIResultPublisher {
        let request = URLRequest(
            url: baseURL.appendingPathComponent(url)
        )
        
        return loadURL(withURLRequest: request)
            .subscribe(on: queueBackgroundInitiated)
            .eraseToAnyPublisher()
    }
    
    private func loadURL(withURLRequest request:URLRequest) -> APIResultPublisher {
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { result in
                
                guard let response = result.response as? HTTPURLResponse else{
                    throw URLError(.badServerResponse)
                }
                return (result.data, response.statusCode)
            }.eraseToAnyPublisher()
    }
    
}
