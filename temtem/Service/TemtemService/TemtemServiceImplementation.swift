//
//  TemtemServiceImplementation.swift
//  temtem
//
//  Created by marlon von ansale on 31/10/2022.
//

import Combine
import Foundation

public final class TemtemServiceImplementation: TemtemService {
    let apiService: APIService
    
    init(apiService: APIService = APIServiceImplementation()) {
        self.apiService = apiService
    }
    
    func fetchAllTemtems() -> TemtemLoader {
        return self.apiService.dispatch(withAppendURL: "api/temtems")
                    .tryMap(TemtemMapper.map)
                    .eraseToAnyPublisher()
    }
}
