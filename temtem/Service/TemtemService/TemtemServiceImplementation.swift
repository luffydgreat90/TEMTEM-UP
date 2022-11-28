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
    
    init(apiService: APIService = APIService()) {
        self.apiService = apiService
    }
    
    func fetchAllTemtems() -> TemtemLoader {
        return self.apiService.getData(appendURL: "api/temtems")
                    .tryMap(TemtemMapper.map)
                    .eraseToAnyPublisher()
    }
}
