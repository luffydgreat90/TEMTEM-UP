//
//  ImageDataServiceTest.swift
//  TemtemFeedTests
//
//  Created by Marlon Ansale on 12/10/22.
//

import Foundation
import Combine

public protocol ImageDataService {
    func loadImage(withURL url:URL) -> AnyPublisher<Data,Never>
}

public class ImageURLSessionDataService: ImageDataService {
    let urlSession:URLSession
    
    init(urlSession:URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    func loadImage(withURL url:URL) -> AnyPublisher<Data,Never> {
        self.urlSession.dataTaskPublisher(for: URLRequest(url: url)).tryMap { result in
            guard  let response = result.response as? HTTPURLResponse else{
                throw URLError(.badServerResponse)
            }
            
            return result.data
        }.eraseToAnyPublisher()
    }
}

