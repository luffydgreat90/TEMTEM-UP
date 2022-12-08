//
//  TemtemServiceImplementation.swift
//  temtem
//
//  Created by marlon von ansale on 31/10/2022.
//

import Combine
import Foundation

public final class TemtemServiceImplementation: TemtemService {
    let apiService: HTTPClient
    
    init(apiService: HTTPClient = URLSessionHTTPClient()) {
        self.apiService = apiService
    }
    
    public func fetchAllTemtems() -> TemtemLoader {
        let url: URL = URL(string: "\(String.urlBase)api/temtems")!
        return self.apiService.dispatch(withURL: url)
                    .tryMap(TemtemMapper.map)
                    .eraseToAnyPublisher()
    }
}
