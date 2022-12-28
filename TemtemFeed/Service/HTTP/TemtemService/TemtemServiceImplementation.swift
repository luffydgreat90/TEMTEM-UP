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
    
	public init(httpClient: HTTPClient = URLSessionHTTPClient()) {
        self.httpClient = httpClient
    }
    
    public func fetchAllTemtems() -> TemtemLoader {
        let url: URL = URL(string: "\(String.urlBase)api/temtems")!
        return self.httpClient.dispatch(withURL: url)
                    .tryMap(TemtemMapper.map)
                    .eraseToAnyPublisher()
    }
}
