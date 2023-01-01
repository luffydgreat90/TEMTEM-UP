//
//  TemtemServiceImplementation.swift
//  temtem
//
//  Created by marlon von ansale on 31/10/2022.
//

import Combine
import Foundation

public final class TemtemServiceImplementation: TemtemService {
    let httpClient: HTTPClient
	let baseURL: URL
	
	public init(httpClient: HTTPClient, baseURL:URL) {
        self.httpClient = httpClient
		self.baseURL = baseURL
    }
    
    public func fetchAllTemtems() -> TemtemLoader {
        let url: URL = baseURL.appendingPathComponent("/api/temtems")
        return self.httpClient.dispatch(withURL: url)
                    .tryMap(TemtemMapper.map)
                    .eraseToAnyPublisher()
    }
}
