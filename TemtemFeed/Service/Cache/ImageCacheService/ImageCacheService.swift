//
//  ImageCacheService.swift
//  TemtemFeed
//
//  Created by Marlon Ansale on 12/10/22.
//

import Foundation
import Combine

public protocol ImageCacheService {
	func insert(_ data:Data, for url: URL) throws
	func retrieve(dataForURL url:URL) -> AnyPublisher<Data,Swift.Error>
}
