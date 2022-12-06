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
        return self.apiService.dispatch(withAppendURL: "api/temtems")
                    .tryMap(TemtemMapper.map)
                    .eraseToAnyPublisher()
    }
}
