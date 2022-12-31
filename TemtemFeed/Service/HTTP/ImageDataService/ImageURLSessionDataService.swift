//
//  ImageDataServiceImplementation.swift
//  TemtemFeed
//
//  Created by Marlon Ansale on 12/16/22.
//

import Foundation
import Combine

public class ImageURLSessionDataService: ImageDataService {
	let httpClient:HTTPClient
	
	public init(httpClient:HTTPClient) {
		self.httpClient = httpClient
	}
	
	public func loadImage(withURL url:URL) -> AnyPublisher<(Data, HTTPURLResponse),Error> {
		self.httpClient.dispatch(withURL: url).eraseToAnyPublisher()
	}
}
