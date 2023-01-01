//
//  ImageNSCacheService.swift
//  temtem
//
//  Created by Marlon Ansale on 12/10/22.
//

import Foundation
import Combine

public final class ImageNSCacheService: ImageCacheService {
	private let cache:NSCache<NSURL,NSData>
	
	private enum Error: Swift.Error {
		case notFound
	}
	
	public init(cache: NSCache<NSURL,NSData> = NSCache()) {
		self.cache = cache
	}
	
	public func insert(_ data:Data, for url: URL) throws {
		cache.setObject(data as NSData, forKey: url as NSURL)
	}
	
	public func retrieve(dataForURL url: URL) -> AnyPublisher<Data, Swift.Error> {
		return Deferred {
			Future { promise in
				if let data = self.cache.object(forKey: url as NSURL) as? Data {
					promise(.success(data))
				}else{
					promise(.failure(Error.notFound))
				}
			}
		}.eraseToAnyPublisher()
	}
	
}

