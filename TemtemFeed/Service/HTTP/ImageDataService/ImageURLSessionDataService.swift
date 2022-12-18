//
//  ImageDataServiceImplementation.swift
//  TemtemFeed
//
//  Created by Marlon Ansale on 12/16/22.
//

import Foundation
import Combine

public class ImageURLSessionDataService: ImageDataService {
	let urlSession:URLSession
	
	public init(urlSession:URLSession = .shared) {
		self.urlSession = urlSession
	}
	
	public func loadImage(withURL url:URL) -> AnyPublisher<Data,Error> {
		self.urlSession.dataTaskPublisher(for: URLRequest(url: url)).tryMap { result in
			guard  result.response is HTTPURLResponse else{
				throw URLError(.badServerResponse)
			}
			
			return result.data
		}.eraseToAnyPublisher()
	}
}
