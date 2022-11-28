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
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        
        return self.apiService.getData(appendURL: "api/temtems")
                    .decode(type: [Temtem].self, decoder: jsonDecoder)
                    .tryMap({ temtems in
                        temtems.map{ TemtemViewModel(temtem: $0) }
                    })
                    .eraseToAnyPublisher()
    }
}
